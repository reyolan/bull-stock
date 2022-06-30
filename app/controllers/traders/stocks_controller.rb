# Trader User Story #5, #6, and #8
class Traders::StocksController < ApplicationController
  before_action :authenticate_trader

  def index
    # User Story #6
    @stocks = current_user.stocks.order(:symbol)
  end
end
