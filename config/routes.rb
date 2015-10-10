Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users, controllers:  { registrations: :registrations }
  resources :homes, only: [:index]
  resources :users, only: [:show]
  resources :animals, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :foster_offers
end
