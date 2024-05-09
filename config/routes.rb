Rails.application.routes.draw do
  resources :items
  resources :collections
  devise_for :users


end
