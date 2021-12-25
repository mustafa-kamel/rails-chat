Rails.application.routes.draw do
  resources :applications, only: %i[index show create] do
    resources :chats, only: %i[index show create] do
      resources :messages, only: %i[index show create update]
      get '/search/:query', to: 'messages#search'
    end
  end
end
