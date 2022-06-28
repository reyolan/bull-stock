class Traders::SoldStocksController < ApplicationController
  def create
    # subtract quantity
    # find the stock
    stock = current_user.stocks.find(params[:id])
    stock.update(sold_stock_params)
    redirect_to portfolio_url, success: "Successfully sold #{stock.quantity} shares of #{stock.company_name}."
  end

  private

  def sold_stock_params
    params.require(:sold_stock).permit(:quantity)
  end
end
