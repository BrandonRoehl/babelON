json.extract! message, :id, :user_id, :time_sent, :time_read, :base_id, :created_at, :updated_at
json.url message_url(message, format: :json)
json.content message.local(params[:lang] || current_user.lang).content
json.original message.base.content
json.username message.user.username
