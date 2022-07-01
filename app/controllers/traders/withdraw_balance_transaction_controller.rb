class Traders::WithdrawBalanceTransactionController < ApplicationController
  def new
    @deposit_transaction = current_user.balance_transactions.build
  end

  def create
    @deposit_transaction = current_user.balance_transactions.build(deposit_transaction_params)
  end

  private

  def deposit_transaction_params
    params.require(:deposit_transaction).permit(:balance)
  end
end
