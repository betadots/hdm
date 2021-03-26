Rails.application.routes.draw do
  resources :roles, only: [:show, :index]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  get 'page/index'
  get 'page/about_us'
  get 'page/faulty_setup'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  root to: 'page#index'
end
