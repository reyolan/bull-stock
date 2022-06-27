# Trader User Story #7
class Traders::TransactionsController < ApplicationController
  def index
    # User Story #7
    @transactions = current_user.transactions
  end

  def new
    # User Story #5
    # buying a new stock share (trader must not yet bought the stock)
    @transaction = current_user.transaction.build
  end

  def create
    # User Story #5
    @transaction = current_user.transaction.build
    if @transaction.save
      redirect_to transactions_url, notice: 'Successfully completed a transaction.'
    else
      render :new
    end
  end
end
