class Traders::DepositBalanceTransactionsController < ApplicationController
  def new
    @deposit_transaction = current_user.balance_transactions.build
  end

  def create
    @deposit_transaction = current_user.balance_transactions.build(deposit_transaction_params)
    if @deposit_transaction.save
      current_user.balance.deposit(@deposit_transaction.amount)
      redirect_to trader_balance_transactions_url, success: "Successfully deposited $#{@deposit_transaction.amount}."
    else
      render :new
    end
  end

  private

  def deposit_transaction_params
    params.require(:deposit_transaction).permit(:balance)
  end
end
