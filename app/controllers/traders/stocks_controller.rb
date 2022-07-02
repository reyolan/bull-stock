class Traders::StocksController < ApplicationController
  before_action :authenticate_trader

  def index
    @stocks = current_user.stocks.asc_symbol
    @stocks_value = current_user.stocks.overall_amount
    @number_of_shares = current_user.stocks.overall_shares
  end
end
