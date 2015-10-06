Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users, controllers:  { registrations: :registrations }
  resources :homes, only: [:index]
  resources :users
end
