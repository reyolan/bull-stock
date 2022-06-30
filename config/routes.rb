Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end

  scope module: 'admins' do
    resources :pending_traders, only: :index
    resources :approved_traders, only: :create
    resources :traders
    resources :transactions
  end

  scope module: 'traders' do
    resources :stocks, only: :index, path: 'portfolio', as: 'trader_stocks'

    resources :buy_transactions, only: :create, path: 'buy'
    get 'buy/:symbol', to: 'buy_transactions#new', as: 'new_buy_transaction'

    resources :sell_transactions, only: :create, path: 'sell'
    get 'sell/:symbol', to: 'sell_transactions#new', as: 'new_sell_transaction'

    resources :transactions, only: :index, as: 'trader_transactions', path: 'portfolio/transactions'

    resources :search_stocks, only: %i[new create]
  end

  root 'static_pages#home'
end
