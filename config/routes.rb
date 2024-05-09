Rails.application.routes.draw do
  resources :comments
  resources :items
  resources :collections
  devise_for :users


end
