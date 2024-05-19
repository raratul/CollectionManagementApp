Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :tags, only: [:index]
  resources :collections do
    resources :items do
      resources :comments, only: [:create]
    end
  end
  
  resources :likes

  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end

  get 'search', to: 'search#index'
  get 'tag/:tag', to: 'search#tagged', as: :tag
  get 'latest_items', to: 'items#latest_items', as: :latest_items

  get 'admin', to: 'admin#index', as: :admin
  get 'admin/block_user/:id', to: 'admin#block_user', as: :block_user
  get 'admin/unblock_user/:id', to: 'admin#unblock_user', as: :unblock_user
  get 'admin/delete_user/:id', to: 'admin#delete_user', as: :delete_user
  get 'admin/add_admin/:id', to: 'admin#add_admin', as: :add_admin
  get 'admin/remove_admin/:id', to: 'admin#remove_admin', as: :remove_admin

  get 'toggle_language', to: 'application#toggle_language'
  post 'toggle_theme', to: 'application#toggle_theme'
  patch 'batch_action_admin', to: 'admin#batch_action'

  root to: 'home#index'
end
