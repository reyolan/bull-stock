Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: "users/sessions", registrations: "users/registrations"}

  scope module: "admins" do
    resources :pending_traders, only: :index, path: "traders/pending"
    resources :approved_traders, only: :update
    resources :traders
    resources :stock_transactions, only: :index, path: "transactions/stock"
    resources :balance_transactions, only: :index, path: "transactions/balance"
  end

  scope module: "traders" do
    resources :stocks, only: :index, path: "portfolio", as: "trader_stocks"

    resources :buy_stock_transactions, only: %i[index create], path: "portfolio/buy"
    get "buy/:symbol", to: "buy_stock_transactions#new", as: "new_buy_stock_transaction"

    resources :sell_stock_transactions, only: %i[index create], path: "portfolio/sell"
    get "sell/:symbol", to: "sell_stock_transactions#new", as: "new_sell_stock_transaction"

    resources :stock_transactions, only: :index, as: "trader_stock_transactions", path: "portfolio/transactions"

    resource :search_stock, only: %i[new create], path: "search"

    resource :balance, only: :show, as: "trader_balance"

    resources :balance_transactions, only: :index, as: "trader_balance_transactions", path: "balance/transactions"

    resources :deposit_balance_transactions, only: %i[index new create], path: "balance/deposit"
    resources :withdraw_balance_transactions, only: %i[index new create], path: "balance/withdraw"
  end

  root "static_pages#home"
end
