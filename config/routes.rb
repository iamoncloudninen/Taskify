Rails.application.routes.draw do
  get 'reactions/create'
  get 'reactions/destroy'
  get 'pomodoro/index'
  get 'dashboard/show'
  get 'timers', to: 'timers#index'
  resources :timeline
  resources :timeline_posts do
    resources :reactions, only: [:create, :destroy]
  end
  resources :tasks do
    patch :complete, on: :member
    patch :incomplete, on: :member
  end
  devise_for :users
  resources :users, only: [:show, :index, :edit, :update, :destroy]
  root to: "home#index"
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end  
end
