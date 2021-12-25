class CreateMessageWorker
  include Sidekiq::Worker

  def perform(app_token, chat_num, body, message_num)
    @chat = Application.find_by(token: app_token)&.chats&.find_by(number: chat_num)
    @chat.messages.create!(body: body, number: message_num)
  end
end
