json.extract! message, :id, :user_id, :time_sent, :time_read, :base_id, :created_at, :updated_at
json.url message_url(message, format: :json)
