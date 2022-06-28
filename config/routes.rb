Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: 'admins' do
    resources :pending_traders, only: :index
    resources :approved_traders, only: :create
    resources :traders
    resources :transactions, only: :index, as: 'admin_transactions'
  end

  scope module: 'traders' do
    resources :stocks, except: :index

    resources :bought_stocks, only: :create
    patch 'bought_stocks/:symbol', to: 'bought_stocks#update', as: 'bought_stock'

    resources :sold_stocks, only: :create
    get 'sold_stocks/:symbol', to: 'sold_stocks#new', as: 'new_sold_stock'

    get 'portfolio', to: 'stocks#index'
    resources :transactions, as: 'trader_transactions'
    resources :search_stocks, only: %i[new create]
    get 'search_stocks/:symbol', to: 'search_stocks#show', as: 'search_stock'
  end

  root 'static_pages#home'
end
