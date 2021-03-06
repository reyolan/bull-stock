class Admins::BalanceTransactionsController < ApplicationController
  before_action :authorize_admin

  def index
    @q = BalanceTransaction.all.desc_created_at.includes(:user).ransack(params[:q])
    @balance_transactions = @q.result.page(params[:page])
  end
end
