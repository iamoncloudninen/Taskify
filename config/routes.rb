# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :users, except: %i[new create]
  resources :timeline, only: [:index, :new, :create, :destroy] do
    resources :reactions, only: %i[create destroy]
  end  
  resources :tasks do
    member do
      patch :complete
      patch :incomplete
    end
  end
  resources :timers, only: [:index]
  get 'pomodoro/index'
  get 'dashboard/show'

  get 'reactions/create', to: 'reactions#create'
  get 'reactions/destroy', to: 'reactions#destroy'
end
