Rails.application.routes.draw do
  root  'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts do
    member do
      get :quote
    end
  end
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:show, :create, :destroy, :edit, :update]
  resources :relationships,       only: [:create, :destroy]
  resources :reposts,             only: [:create, :destroy]
  resources :comments,            only: [:create]
  resources :likes,               only: [:create, :destroy]
end
