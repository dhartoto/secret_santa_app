Rails.application.routes.draw do
  root 'participants#index'
  resources :participants, only: :create
end
