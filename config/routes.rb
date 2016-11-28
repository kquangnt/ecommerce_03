Rails.application.routes.draw do
  namespace :admin do
    root "manage#home"
    resources :users
  end

  root "static_pages#home"
  devise_for :users
  devise_for :admins
  resources :users, only: [:index, :show]
end
