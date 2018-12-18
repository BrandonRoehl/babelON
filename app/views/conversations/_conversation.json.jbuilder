json.extract! conversation, :id, :created_at, :updated_at
json.url conversation_url(conversation, format: :json)
json.usernames conversation.users.map { |user| user.username }
