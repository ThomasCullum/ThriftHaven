Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"

  resources :carts do
    delete 'item/:id', to: 'carts#remove_item', as: 'remove_cart_item'
  end

  resources :carts, only: [:show] do
    post 'add_item/:item_id', action: :add_item, on: :member, as: :add_item
    delete 'remove_item/:item_id', action: :remove_item, on: :member, as: :remove_item
    delete 'clear_cart', action: :clear_cart, on: :member, as: :clear_cart
  end

  resources :items, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    member do
      get 'add_to_cart'
      post 'add_to_cart'
      delete 'remove_from_cart'
    end
    resources :bids, only: [:new, :create] do
      patch 'approve', on: :member
      patch 'decline', on: :member
    end
  end

  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    # post 'add_to_cart', on: :member
    delete 'remove_from_cart', on: :member
  end

  resources :cart_items, only: [:create, :update, :destroy]

  post 'checkout', to: 'items#checkout'

  get "up" => "rails/health#show", as: :rails_health_check
end
