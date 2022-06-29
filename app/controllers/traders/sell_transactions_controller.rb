class Traders::SellTransactionsController < ApplicationController
  before_action :request_iex_resource

  def new
    @quote = @client.quote(params[:symbol])
    @stock = current_user.stocks.find_by!(symbol: params[:symbol])
    @transaction = current_user.transactions.build
  end

  def create
    @transaction = current_user.transactions.build(sell_transaction_params)
    @stock = existing_stock
    if @transaction.valid? && @stock.valid?
      ActiveRecord::Base.transaction do
        @transaction.save_sell
        @stock.sell_share(sold_stock_params)
      end
      redirect_to trader_stocks_url, success: "Successfully sold shares of #{@stock.company_name}."
    else
        request_iex_quote
        render :new
    end
  end

  private

  def existing_stock
    current_user.stocks.find_by!(symbol: params[:sell_transaction][:symbol])
  end

  def sold_stock_params
    params.require(:sell_transaction).permit(:quantity, :unit_price)
  end

  def sell_transaction_params
    params.require(:sell_transaction).permit(:symbol, :company_name, :quantity, :unit_price)
  end

  def request_iex_quote
    request_iex_resource
    @quote = @client.quote(params[:sell_transaction][:symbol])
  end
end
