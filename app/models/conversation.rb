class Conversation < ApplicationRecord
    # has_many :users
    has_many :messages, dependent: :destroy
    has_and_belongs_to_many :users

    def display_users(user = nil)
        (user.nil? ? self.users : self.users.where.not(id: user.id)).map do |user|
            user.first_name
        end.join(', ')
    end
end
