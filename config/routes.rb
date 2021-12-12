Rails.application.routes.draw do
  resources :applications, only: %i[index show create] 
end
