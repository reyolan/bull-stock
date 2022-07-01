Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

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

    resources :stock_transactions, only: :index, as: 'trader_stock_transactions', path: 'portfolio/transactions'

    resource :search_stock, only: %i[new create], path: 'search'
    resource :balance
  end

  root 'static_pages#home'
end
