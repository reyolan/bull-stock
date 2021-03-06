class Admins::StockTransactionsController < ApplicationController
  before_action :authorize_admin

  def index
    @q = StockTransaction.all.desc_created_at.includes(:user).ransack(params[:q])
    @stock_transactions = @q.result.page(params[:page])
  end
end
