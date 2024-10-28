Rails.application.routes.draw do
  get 'dashboard/show'
  get 'timeline/index'
  resources :tasks
  devise_for :users
  resources :users, only: [:show, :index, :edit, :update]
  root to: "home#index"
end
