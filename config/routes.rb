Rails.application.routes.draw do
  root 'participants#index'
  resources :participants, only: :create
  resources :secret_santa_results, only: :show
end
