class UpdateChatWorker
  include Sidekiq::Worker

  def perform
    Chat.all.each do|chat|
        chat.messages_count = chat.messages.count
        chat.save
    end
  end
end
