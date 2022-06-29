# Trader User Story #5, #6, and #8
class Traders::StocksController < ApplicationController
  def index
    # User Story #6
    @stocks = current_user.stocks.order(:symbol)
  end
    # Stock.transaction do
    #   current_user.stocks.create!(stock_params)
    #   # log transaction
    #   current_user.transactions.create!(stock_params, unit_price: @client.price, transaction_type: 1)
    # end
end
