json.partial! "conversations/conversation", conversation: @conversation
json.messages @conversation.messages do |message|
  json.partial! "messages/message", message: message
end
json.users @conversation.users