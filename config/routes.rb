Rails.application.routes.draw do
  root 'participants#index'
  resources :participants, only: :create
  resources :results, only: [:show, :destroy]
end
