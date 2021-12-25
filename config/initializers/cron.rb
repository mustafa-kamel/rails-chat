Rails.application.reloader.to_prepare do
    Sidekiq::Cron::Job.create(name: "Update apps' chats_count - every 1hr", cron: '0 * * * *', class: 'UpdateAppWorker')
    Sidekiq::Cron::Job.create(name: "Update chats' messages_count - every 1hr", cron: '0 * * * *', class: 'UpdateChatWorker')
end