Rails.application.routes.draw do
  resources :applications, only: %i[index show create] do
    resources :chats, only: %i[index show create] do
      resources :messages, only: %i[index show create]
    end
  end
end
