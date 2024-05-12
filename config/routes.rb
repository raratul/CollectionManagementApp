Rails.application.routes.draw do
    resources :user_collections
    resources :likes
    devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
    root to: 'collections#index'

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
    patch 'admin/block_user/:id', to: 'admin#block_user', as: :block_user
    patch 'admin/unblock_user/:id', to: 'admin#unblock_user', as: :unblock_user
    delete 'admin/delete_user/:id', to: 'admin#delete_user', as: :delete_user

    resources :users, only: [] do
      resources :collections, controller: 'user_collections', only: [:index]
    end
end
  


