class Traders::DepositBalanceTransactionController < ApplicationController
  def new
    @withdraw_transaction = current_user.balance_transactions.build
  end

  def create
    @withdraw_transaction = current_user.balance_transactions.build(deposit_transaction_params)
    if @withdraw_transaction.save
      current_user.balance.deposit(@withdraw_transaction.amount)
      redirect_to trader_balance_transactions_url, success: "Successfully deposited $#{@withdraw_transaction.amount}."
    else
      render :new
    end
  end

  private

  def deposit_transaction_params
    params.require(:deposit_transaction).permit(:balance)
  end
end
