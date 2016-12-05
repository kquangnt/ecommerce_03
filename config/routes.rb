Rails.application.routes.draw do
  namespace :admin do
    root "home#index"
    resources :categories
  end
  root "static_pages#home"
  devise_for :users
  resources :users, only: [:index, :show, :destroy]
  resources :categories, only: :index
end
