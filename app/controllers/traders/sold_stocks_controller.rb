class Traders::SoldStocksController < ApplicationController
  def create
    stock = current_user.stocks.find(params[:id])
    if stock.add_share(sold_stock_params)
      redirect_to portfolio_url, success: "Successfully sold #{stock.quantity} shares of #{stock.company_name}."
    else
      render 'traders/search_stocks/show'
    end
  end

  private

  def sold_stock_params
    params.require(:sold_stock).permit(:quantity)
  end
end
