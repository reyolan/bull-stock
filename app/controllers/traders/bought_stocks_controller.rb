class Traders::BoughtStocksController < ApplicationController
  def create
    stock = current_user.stocks.build(bought_stock_params)
    if stock.save
      redirect_to portfolio_url, success: "Successfully bought shares of #{stock.company_name}."
    else
      render 'traders/search_stocks/show'
    end
  end

  def update
    stock = current_user.stocks.find_by(symbol: params[:symbol])
    if stock.buy_share(bought_stock_params)
      redirect_to portfolio_url, success: "Successfully bought shares of #{stock.company_name}."
    else
      render 'traders/search_stocks/show'
    end
  end

  def destroy
    # selling of stocks
  end

  private

  def bought_stock_params
    params.require(:bought_stock).permit(:symbol, :company_name, :quantity, :unit_price, :amount)
  end
end
