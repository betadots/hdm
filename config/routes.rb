Rails.application.routes.draw do
  resources :environments, only: :index do
    resources :nodes, only: :index do
      if Rails.configuration.hdm['read_only']
        resources :keys, only: [:index, :show]
      else
        resources :keys, only: [:index, :show, :update, :destroy]
      end
    end
  end
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
