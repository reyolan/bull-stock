Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: 'admins' do
    resources :pending_traders, only: :index
    resources :approved_traders, only: :create
    resources :traders
    resources :transactions
  end

  scope module: 'traders' do
    resources :stocks, only: %i[new create update destroy]
    get 'portfolio', to: 'stocks#index'
    resources :transactions, only: :index
  end

  root 'static_pages#home'
end
