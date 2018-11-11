json.extract! conversation, :id, :created_at, :updated_at, :messages
json.url conversation_url(conversation, format: :json)
