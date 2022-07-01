class Traders::BalanceTransactionsController < ApplicationController
  def index
    @balance_transactions = current_user.balance_transactions.order(created_at: :desc)
  end
end
