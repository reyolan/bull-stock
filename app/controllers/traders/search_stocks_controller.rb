class Traders::SearchStocksController < ApplicationController
  before_action :authenticate_trader

  def new; end

  def create
    if params[:symbol] == ''
      redirect_to new_search_stock_url, danger: 'Please input a symbol.'
    else
      redirect_to new_buy_stock_transaction_url(params[:symbol])
    end
  end
end
