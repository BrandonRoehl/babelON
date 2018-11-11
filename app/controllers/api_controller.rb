class ApiController < ApplicationController

    # TODO: find a way to make this not n^2
    def send_msg
        # usernames: [dave, brandon, connor]
        # content: "message"
        # users = User.where(username: params[:usernames])
        # username[]

        usernames = params[:usernames]
        usernames.push(current_user.username) unless usernames.include?(current_user.username)
        # Find a conversation with the correct users
        conv = current_user.conversations.find do |conversation|
            conversation.users.collect do |user|
                user.username
            end.sort == usernames.sort
        end

        # If it is nil create a new conversation
        if conv.nil?
            conv = Conversation.create!
            User.where(usernames: usernames).each do |user|
                user.conversations << conv
            end
        end

        # Create the message
        msg = Message.new(user: current_user, conversation: conv, time_sent: Time.now)
        # Create the localization
        local = Localization.new(content: params[:content], lang: current_user.lang, message: msg)
        # Set the base msg for show
        msg.base = local
        # Save the msg to persist the data
        local.save!
        msg.save!
    end

    def get_conversations
    end

    def make_msg
    end
end
