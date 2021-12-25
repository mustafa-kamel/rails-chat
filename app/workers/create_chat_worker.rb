class CreateChatWorker
  include Sidekiq::Worker

  def perform(app_token, chat_num)
    @application = Application.find_by(token: app_token)
    @application.chats.create!(number: chat_num)
  end
end
