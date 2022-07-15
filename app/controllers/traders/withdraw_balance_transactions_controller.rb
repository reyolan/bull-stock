class Traders::WithdrawBalanceTransactionsController < ApplicationController
  before_action :authorize_approved_trader

  def index
    @withdraw_transactions = current_user.balance_transactions.withdrawals.page(params[:page])
  end

  def new
    @withdraw_transaction = current_user.balance_transactions.build
  end

  def create
    @withdraw_transaction = current_user.balance_transactions.build(withdraw_transaction_params).withdraw_type
    @current_user_balance = current_user.subtract_amount(@withdraw_transaction.amount)
    ActiveRecord::Base.transaction do
      @current_user_balance.save!
      @withdraw_transaction.save!
    end
    redirect_to trader_balance_url, success: "Successfully withdrew $#{@withdraw_transaction.amount}.
                                                           Remaining balance is: $#{current_user.balance}"
  rescue ActiveRecord::RecordInvalid
    render :new
  end

  private

  def withdraw_transaction_params
    params.require(:withdraw_transaction).permit(:amount)
  end
end
