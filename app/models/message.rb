class Message < ApplicationRecord
    belongs_to :user
    belongs_to :conversation
    belongs_to :base, class_name: 'Localization', optional: true
    has_many :localizations, dependent: :destroy

    @@translate = Google::Cloud::Translate.new

    def local(lang)
        localization = self.localizations.find_by(lang: lang)
        if localization.nil?
            return nil if self.base.nil?

            translation = @@translate.translate(self.base.content, from: self.base.lang, to: lang)
            localization = Localization.new(content: translation, lang: lang, message: self)
            localization.save!
        end
        return localization
    end
end
