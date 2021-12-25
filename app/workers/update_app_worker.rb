class UpdateAppWorker
  include Sidekiq::Worker

  def perform
    Application.all.each do|app|
        app.chats_count = app.chats.count
        app.save
    end
  end
end
