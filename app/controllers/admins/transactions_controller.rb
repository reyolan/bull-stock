class Admins::TransactionsController < ApplicationController
  before_action :authorize_admin

  def index
    @q = StockTransaction.all.ransack(params[:q])
    @transactions = @q.result
  end
end
