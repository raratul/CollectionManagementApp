Rails.application.routes.draw do
  devise_for :users
  resources :likes
  resources :tags
  resources :comments
  resources :items
  resources :collections
  resources :users
  root "users#index"
end
