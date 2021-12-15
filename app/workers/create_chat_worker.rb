class CreateChatWorker
  include Sidekiq::Worker

  def perform(application, last_chat_num)
    binding.irb
    byebug
    application.chats.create!(number: last_chat_num)
  end
end
