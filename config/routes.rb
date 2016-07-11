Rails.application.routes.draw do
  devise_for :users

  resources :messages, only: [:index, :create]

  root to: "messages#index"
end
