class Traders::StockTransactionsController < ApplicationController
  before_action :authenticate_trader, :authenticate_approved_trader

  def index
    @stock_transactions = current_user.stock_transactions.order(created_at: :desc)
  end
end
