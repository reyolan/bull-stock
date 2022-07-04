class Admins::StockTransactionsController < ApplicationController
  before_action :authenticate_admin

  def index
    @q = StockTransaction.all.desc_created_at.ransack(params[:q])
    @stock_transactions = @q.result
  end
end
