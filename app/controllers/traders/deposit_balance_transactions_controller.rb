class Traders::DepositBalanceTransactionsController < ApplicationController
  before_action :authorize_approved_trader

  def index
    @deposit_transactions = current_user.balance_transactions.deposits.page(params[:page])
  end

  def new
    @deposit_transaction = current_user.balance_transactions.build
  end

  def create
    @deposit_transaction = current_user.balance_transactions.build(deposit_transaction_params).deposit_type
    @current_user_balance = current_user.add_amount(@deposit_transaction.amount)
    ActiveRecord::Base.transaction do
      @current_user_balance.save!
      @deposit_transaction.save!
    end
    redirect_to trader_balance_url, success: "Successfully deposited $#{@deposit_transaction.amount}."
  rescue ActiveRecord::RecordInvalid
    render :new
  end

  private

  def deposit_transaction_params
    params.require(:deposit_transaction).permit(:amount)
  end
end
