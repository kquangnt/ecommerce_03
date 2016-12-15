Rails.application.routes.draw do
  namespace :admin do
    root "home#index"
    resources :categories
    resources :books
  end
  root "static_pages#home"
  devise_for :users
  resources :users, only: [:index, :show, :destroy]
  resources :categories, only: :index
  resources :books, only: [:index, :show] do
    resources :reviews
  end

  resources :carts
end
