# Admin User Story # 7
class Admins::TransactionsController < ApplicationController
  before_action :authenticate_admin

  def index
    # User Story #7
    @q = StockTransaction.all.ransack(params[:q])
    @transactions = @q.result
  end
end
