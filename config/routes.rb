Rails.application.routes.draw do
  namespace :admin do
    root "home#index"
    resources :categories
    resources :books
    resources :orders
    resources :carts, only: [:show, :destroy]
  end
  root "static_pages#home"
  devise_for :users
  resources :users, only: [:index, :show]
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  resources :users, only: [:index, :show, :destroy] do
    resources :orders
  end
  resources :categories, only: :index
  resources :books, only: [:index, :show] do
    resources :ratings
    resources :comments do
      resources :answers
    end
  end

  resources :orders
  resources :history_orders
  resources :carts
  resources :order_details
end
