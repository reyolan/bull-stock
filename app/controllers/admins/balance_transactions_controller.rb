class Admins::BalanceTransactionsController < ApplicationController
  before_action :authenticate_admin

  def index
    @q = BalanceTransaction.all.desc_created_at.ransack(params[:q])
    @balance_transactions = @q.result
  end
end
