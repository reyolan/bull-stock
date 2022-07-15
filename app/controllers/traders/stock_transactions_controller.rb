class Traders::StockTransactionsController < ApplicationController
  before_action :authorize_approved_trader

  def index
    @stock_transactions = current_user.stock_transactions.desc_created_at.page(params[:page])
  end
end
