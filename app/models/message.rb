class Message < ApplicationRecord
    belongs_to :user
    belongs_to :conversation
    belongs_to :base, class_name: 'Localization', optional: true
    has_many :localizations

    @@translate = Google::Cloud::Translate.new

    def local(lang)
        unless self.localizations.find_by(lang: lang)
            translation = @@translate.translate self.base.content, from: self.base.lang, to: lang
            localization = Localization.new(content: translation, lang: lang, msg: self)
            localization.save!
        end
    end
end
