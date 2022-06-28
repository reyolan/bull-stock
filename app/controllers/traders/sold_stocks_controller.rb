class Traders::SoldStocksController < ApplicationController
  before_action :request_iex_resource, only: :new
  def new
    @quote = @client.quote(params[:symbol])
  end

  def create
    stock = current_user.stocks.find_by(symbol: params[:symbol])
    if stock.add_share(sold_stock_params)
      redirect_to portfolio_url, success: "Successfully sold #{stock.quantity} shares of #{stock.company_name}."
    else
      render 'traders/search_stocks/show'
    end
  end

  private

  def sold_stock_params
    params.require(:sold_stock).permit(:quantity, :symbol, :unit_price)
  end
end
