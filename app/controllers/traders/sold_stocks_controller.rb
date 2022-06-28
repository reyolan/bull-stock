class Traders::SoldStocksController < ApplicationController
  before_action :request_iex_resource
  def new
    @quote = @client.quote(params[:symbol])
    @stock = current_user.stocks.find_by(symbol: params[:symbol])
  end

  def create
    @stock = current_user.stocks.find_by(symbol: params[:sold_stock][:symbol])
    if @stock.sell_share(sold_stock_params)
      redirect_to portfolio_url, success: "Successfully sold shares of #{@stock.company_name}."
    else
      @quote = @client.quote(params[:sold_stock][:symbol])
      render :new
    end
  end

  private

  def sold_stock_params
    params.require(:sold_stock).permit(:quantity, :symbol, :unit_price)
  end
end
