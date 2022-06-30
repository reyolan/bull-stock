class Traders::StocksController < ApplicationController
  before_action :authenticate_trader

  def index
    @stocks = current_user.stocks.order(:symbol)
  end
end
