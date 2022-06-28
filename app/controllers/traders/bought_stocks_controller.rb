class Traders::BoughtStocksController < ApplicationController
  def create
    # add quantity
    # if new_record redirect to this route, if not new_record don sa isang route
  end

  def update
    stock = current_user.stocks.find(params[:id])
    stock.update(sold_stock_params)
    redirect_to portfolio_url, success: "Successfully bought #{stock.quantity} shares of #{stock.company_name}."
  end

  def destroy
    # selling of stocks
  end

  private
  def stock_params
    params.require(:stock).permit(:symbol, :company_name, :quantity)
  end
end
