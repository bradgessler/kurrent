Rails.application.routes.draw do
  resources :events
  resources :messages
  resources :users
  resources :accounts

  root "messages#index"
end
