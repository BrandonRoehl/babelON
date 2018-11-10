class Conversation < ApplicationRecord
    # has_many :users
    has_many :messages
    has_and_belongs_to_many :users
end
