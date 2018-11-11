Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :sessions
      resources :notifications
    end
  end
  mount ActionCable.server => '/cable'
end
