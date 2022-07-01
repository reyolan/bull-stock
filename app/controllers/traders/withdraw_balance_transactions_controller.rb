class Traders::WithdrawBalanceTransactionsController < ApplicationController
  def new
    @withdraw_transaction = current_user.balance_transactions.build
  end

  def create
    @withdraw_transaction = current_user.balance_transactions.build(withdraw_transaction_params)
    if @withdraw_transaction.save
      current_user.balance.withdraw(@withdrawt_transaction.amount)
      redirect_to trader_balance_transactions_url, success: "Successfully withdrew $#{@withdraw_transaction.amount}."
    else
      render :new
    end
  end

  private

  def withdraw_transaction_params
    params.require(:withdraw_transaction).permit(:balance)
  end
end
