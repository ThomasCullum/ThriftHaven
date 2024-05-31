Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"

  resources :carts, only: [:index, :show, :create, :update, :destroy] do
    member do
      post 'add_item/:item_id', to: 'carts#add_item', as: 'add_item'
      delete 'remove_item/:item_id', to: 'carts#remove_item', as: 'remove_item'
      delete 'clear', to: 'carts#clear_cart', as: 'clear'
    end
  end

  resources :items do
    member do
      get 'add_to_cart'
      post 'add_to_cart'
      delete 'remove_from_cart'
      patch :accept_bid
      patch :decline_bid
    end
    resources :bids, only: [:new, :create] do
      patch 'approve', on: :member
      patch 'decline', on: :member
    end
  end

  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    delete 'remove_from_cart', on: :member
  end

  resources :cart_items, only: [:create, :update, :destroy]

  post 'checkout', to: 'items#checkout'

  get "up" => "rails/health#show", as: :rails_health_check
end
