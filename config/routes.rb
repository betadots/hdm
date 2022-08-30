# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  resources :environments, only: :index do
    resources :hierarchies, only: [] do
      resources :decrypted_values, only: [:create]

      resources :encrypted_values, only: [:create]
    end

    resources :keys, only: [] do
      resources :files, only: [:index]
    end

    resources :nodes, only: :index, constraints: {id: /.+/} do
      if Rails.configuration.hdm['read_only']
        resources :keys, only: [:index, :show]
      else
        resources :keys, only: [:index, :show, :update, :destroy] do
          resources :hierarchies, only: [] do
            resources :data_files, only: [] do
              resource :value, only: [:update, :destroy]
            end
          end
        end
      end
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  resource :ldap_session, only: [:new, :create]

  get 'page/index'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  root to: 'page#index'
end
# rubocop:enable Metrics/BlockLength
