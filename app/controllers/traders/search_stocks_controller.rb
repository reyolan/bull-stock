class Traders::SearchStocksController < ApplicationController
  before_action :authenticate_trader, :request_iex_resource

  def new; end

  def create
    redirect_to new_buy_transaction_url(params[:symbol])
  end
end
