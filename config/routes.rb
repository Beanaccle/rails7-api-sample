Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'overrides/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :products, only: %i[create update destroy] do
        scope module: :products do
          resource :purchase, only: :create
        end
      end
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
