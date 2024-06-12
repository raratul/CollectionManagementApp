Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'collections/index'
    end
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :collections, shallow: true do
    resources :items, shallow: true do
      resources :comments, only: [:create, :destroy]
      resource :like, only: [:create, :destroy]
    end
  end

  get 'items/:item_id/comments.:id', to: 'comments#destroy'

  get 'collections-all', to: 'collections#all_collections', as: :all_collections

  get '%23.:id', to: 'collections#destroy', as: :delete_collection

  get '%2523.:id', to: 'items#destroy', as: :delete_item

  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end

  get 'admin', to: 'admin#index', as: :admin
  get 'admin/block_user/:id', to: 'admin#block_user', as: :block_user
  get 'admin/unblock_user/:id', to: 'admin#unblock_user', as: :unblock_user
  get 'admin/delete_user/:id', to: 'admin#delete_user', as: :delete_user
  get 'admin/add_admin/:id', to: 'admin#add_admin', as: :add_admin
  get 'admin/remove_admin/:id', to: 'admin#remove_admin', as: :remove_admin

  get 'toggle_language', to: 'application#toggle_language'
  post 'toggle_theme', to: 'application#toggle_theme'
  patch 'batch_action_admin', to: 'admin#batch_action'

  get 'search', to: 'search#index'

  resources :tickets, only: [:new, :create, :index]
  resource :profile, only: [:show], controller: 'profiles' do
    post :regenerate_api_token, on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :collections, only: [:index]
    end
  end

  root to: 'home#index'
end
