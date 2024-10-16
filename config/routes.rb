Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :index, :edit, :update]
  root to: "home#index"
end
