Rails.application.routes.draw do
  resources :user_collections
  resources :tags
  resources :comments
  resources :items
  resources :collections
  devise_for :users


end
