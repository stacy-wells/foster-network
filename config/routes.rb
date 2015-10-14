Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users, controllers:  { registrations: :registrations }
  resources :homes, only: [:index]
  resources :users, only: [:show]
  resources :animals, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :foster_offers, only: [:create]
  resources :searches

  get :send_mail, to: 'searches#send_mail', as: :send_mail
  get :petfinder_add_all, to: "animals#petfinder_add_all", as: :petfinder_add_all
  post :petfinder_get_all, to: "animals#petfinder_get_all", as: :petfinder_get_all
end
