Rails.application.routes.draw do


  namespace :api do
    namespace :v1 do
      get 'products/index'
      resources :users
      resources :products
      resources :products
      resources :line_items
      resources :orders
      resource :carts, only: [:show]
    end
  end

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
  end
  post '/graphql', to: 'graphql#execute'

  get 'sessions/new'

  namespace :admin do
    resources :products
    resources :users
  end

  resources :products
  resources :line_items
  resources :orders
  resource :carts, only: [:show]

  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end