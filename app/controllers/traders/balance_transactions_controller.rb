class Traders::BalanceTransactionsController < ApplicationController
  before_action :authenticate_approved_trader
  
  def index
    @balance_transactions = current_user.balance_transactions.order(created_at: :desc)
  end
end