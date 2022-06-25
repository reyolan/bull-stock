# Trader User Story #5, #6, and #8
class Traders::StocksController < ApplicationController
  def index
    # User Story #6
    # @stocks = current_user.stocks
  end

  def new
    # User Story #5
    # buying a new stock share (trader must not yet bought the stock)
  end

  def create
    # User Story #5
  end

  def update
    # Slight User Story #5 and User Story #8
    # either buying of share or selling a share.
    # MSFT: 1 share
    # MSFT: 2 shares
  end

  def destroy
    # User Story #8
    # Sell all shares
  end
end
