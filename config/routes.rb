Rails.application.routes.draw do
  resources :tasks
  devise_for :users
  resources :users, only: [:show, :index, :edit, :update]
  root to: "home#index"
end
