Rails.application.routes.draw do
  devise_for :admin_users, {class_name: 'User'}.merge(ActiveAdmin::Devise.config)
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'

      resources :books, only: [:show, :index] do
        collection do
          get 'search/:isbn' => :search
        end
      end

      resources :rents, only: [:show, :create, :index]
      resources :book_suggestions, only: [:create]
    end
  end
end
