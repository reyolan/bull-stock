class Traders::WithdrawBalanceTransactionsController < ApplicationController
  before_action :authenticate_approved_trader
  
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
    redirect_to trader_balance_transactions_url, success: "Successfully withdrew $#{@withdraw_transaction.amount}. 
                                                           Remaining balance is: $#{current_user.balance}"
  rescue ActiveRecord::RecordInvalid
    render :new
  end

  private

  def withdraw_transaction_params
    params.require(:withdraw_transaction).permit(:amount)
  end
end