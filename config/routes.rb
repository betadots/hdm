Rails.application.routes.draw do
  resources :environments, only: :index do
    resources :nodes, only: :index, constraints: {id: /[^\/]+/} do
      if Rails.configuration.hdm['read_only']
        resources :keys, only: [:index, :show]
      else
        resources :decrypted_values, only: [:create]
        resources :encrypted_values, only: [:create]
        resources :keys, only: [:index, :show, :update, :destroy]
      end
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  get 'page/index'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  root to: 'page#index'
end
