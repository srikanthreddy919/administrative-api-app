Rails.application.routes.draw do
  devise_for :users, only: [:sessions], controllers: {
    sessions: 'sessions'
  }
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :users
      resources :tags
    end
  end
end
