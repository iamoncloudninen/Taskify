Rails.application.routes.draw do
  get 'pomodoro/index'
  get 'dashboard/show'
  get 'timers', to: 'timers#index'
  resources :timeline
  resources :tasks do
    patch :complete, on: :member
    patch :incomplete, on: :member
  end
  devise_for :users
  resources :users, only: [:show, :index, :edit, :update]
  root to: "home#index"
end
