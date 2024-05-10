Rails.application.routes.draw do
    root to: 'collections#index'
  
    devise_for :users
  
    resources :collections do
      resources :items
    end
  
    resources :comments

    devise_scope :user do
      get 'users/sign_out' => 'devise/sessions#destroy'
    end
  
    get 'search', to: 'search#index'
    get 'tag/:tag', to: 'search#tagged', as: :tag
    get 'latest_items', to: 'items#latest_items', as: :latest_items
  
    get 'admin', to: 'admin#index', as: :admin

    resources :users, only: [] do
      resources :collections, controller: 'user_collections', only: [:index]
    end
  end
  