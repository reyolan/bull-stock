class Traders::DepositBalanceTransactionsController < ApplicationController
  def new
    @deposit_transaction = current_user.balance_transactions.build
  end

  def create
    @deposit_transaction = current_user.balance_transactions.build(deposit_transaction_params)
    ActiveRecord::Base.transaction do
      current_user.deposit!(@deposit_transaction.amount)
      @deposit_transaction.log_deposit!
    end
    redirect_to trader_balance_transactions_url, success: "Successfully deposited $#{@deposit_transaction.amount}."
  rescue ActiveRecord::RecordInvalid
    render :new
  end

  private

  def deposit_transaction_params
    params.require(:deposit_transaction).permit(:amount)
  end
end
