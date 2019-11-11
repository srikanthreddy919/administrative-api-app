Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      devise_for :users, only: :sessions,
                   path_names: {
                     sign_in: 'login',
                     sign_out: 'logout',
                   },
                   controllers: {
                     sessions: 'sessions'
                   }
      resources :users
    end
  end
end
