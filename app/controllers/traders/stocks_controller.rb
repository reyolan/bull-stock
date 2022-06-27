# Trader User Story #5, #6, and #8
class Traders::StocksController < ApplicationController
  def index
    # User Story #6
    @stocks = current_user.stocks
  end

  def new
    # User Story #5
    # buying a new stock share (trader must not yet bought the stock)
    @stock = current_user.stocks.build
  end

  # User Story #5
  def create
    # User buys stock, so stock is inserted to Stocks table belonging to the user
    # log the transaction
    # NOTE: You can only have a transaction if the buying of stock succeeded. 
    # What if the program crashes during the purchase of the stock?
    Stock.transaction do
      current_user.stocks.create!(stock_params)
      # log transaction
      current_user.transactions.create!(stock_params, unit_price: @client.price, transaction_type: 1,)

    end
  end

  def update
    # Slight User Story #5 and User Story #8
    # either buying of share or selling a share.
    # MSFT: 1 share
    # MSFT: 2 shares
    # log the transaction
    # ibang route yung buy and sell
  end

  def destroy
    # User Story #8
    # Sell all shares
  end

  private

  def stock_params
    params.require(:stock).permit(:symbol, :company_name, :quantity, :amount)
  end

  def set_stock
    @stock = current_user.stocks.find(params[:id])
  end
end
