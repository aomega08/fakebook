Rails.application.routes.draw do
  root to: 'payments#index'

  resources :recipients, only: [:index, :show, :new, :create]
  resources :payments, only: [:show, :new, :create]
end

