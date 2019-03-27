Rails.application.routes.draw do

  namespace :admin do
    resources :products
    resources :users
  end

  resources :products
  resources :order_items
  resource :carts, only: [:show]

  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end