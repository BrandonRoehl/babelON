class ApiController < ApplicationController

    # TODO: find a way to make this not n^2
    def send_msg
        # usernames: [dave, brandon, connor]
        # content: "message"
        # users = User.where(username: params[:usernames])
        # username[]

        # Find a conversation with the correct users
        conv = current_user.conversations.find do |conversation|
            return conversation.users.collect do |user|
                return user.username
            end.sort == params[:usernames].sort
        end

        # If it is nil create a new conversation
        if conv.nil?
            conv = Conversation.create!
            User.where(usernames: params[:usernames]).each do |user|
                user.conversations << conv
            end
        end

        # Create the message
        msg = Message.create!(user: current_user, conversation: conv)
        # Create the localization
        local = Localization.create!(content: params[:content], lang: current_user.lang, message: msg)
        # Set the base msg for show
        msg.base = local
        # Save the msg to persist the data
        msg.save!
    end

    def get_conversations
    end
end
