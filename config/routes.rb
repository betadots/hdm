Rails.application.routes.draw do
  namespace :puppet do
    resources :environments do
      resources :nodes do
        resources :options
      end
    end
    resources :configurations do
      resources :values, only: [:create, :destroy]
    end
  end

  # resources :puppet_environments do
  #   resources :puppet_nodes do
  #     resources :puppet_configurations do
  #       resources :puppet_values, only: [:create, :update, :destroy]
  #     end
  #   end
  # end

  get 'page/index'
  get 'page/about_us'
  get 'page/faulty_setup'
  root to: 'page#index'

  resources :roles, only: [:show, :index]
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
