Rails.application.routes.draw do
  resources :collections
  devise_for :users


end
