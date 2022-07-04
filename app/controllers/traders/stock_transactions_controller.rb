class Traders::StockTransactionsController < ApplicationController
  before_action :authenticate_approved_trader

  def index
    @stock_transactions = current_user.stock_transactions.desc_created_at.page(params[:page])
  end
end
