Rails.application.routes.draw do
  devise_for :users

  resources :messages, only: [:index, :create]
  resources :rules, only: [:new, :create]

  resources :users

  root to: "messages#index"
end
