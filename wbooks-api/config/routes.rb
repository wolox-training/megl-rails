Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
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
