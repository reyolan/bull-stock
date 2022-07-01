class Traders::WithdrawBalanceTransactionsController < ApplicationController
  def new
    @withdraw_transaction = current_user.balance_transactions.build
  end

  def create
    @withdraw_transaction = current_user.balance_transactions.build(withdraw_transaction_params)
    ActiveRecord::Base.transaction do
      current_user.withdraw!(@withdraw_transaction.amount)
      @withdraw_transaction.log_withdraw!
    end
    redirect_to trader_balance_transactions_url, success: "Successfully withdrew $#{@withdraw_transaction.amount}."
  rescue ActiveRecord::RecordInvalid
    render :new
  end

  private

  def withdraw_transaction_params
    params.require(:withdraw_transaction).permit(:amount)
  end
end
