Rails.application.routes.draw do
  get 'dashboard/show'
  get 'timeline/index'
  resources :tasks do
    patch :complete, on: :member
    patch :incomplete, on: :member
  end
  devise_for :users
  resources :users, only: [:show, :index, :edit, :update]
  root to: "home#index"
end
