class Traders::BalanceTransactionsController < ApplicationController
  def index
    current_user.balance_transactions.order(created_at: :desc)
  end
end
