Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :editor, only: [:index]
  resources :environments, only: [:show], id: /[^\/]+/ do
    resources :nodes, only: [:show], on: :member  do
      if Settings.read_only
        resources :keys, only: [:show], on: :member
      else
        resources :keys, only: [:show, :update, :create, :destroy], on: :member
      end
    end
  end
  root to: "editor#index"
end
