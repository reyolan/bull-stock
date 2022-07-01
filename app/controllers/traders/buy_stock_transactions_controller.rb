class Traders::BuyStockTransactionsController < ApplicationController
  before_action :authenticate_trader, :request_iex_resource

  def new
    @quote = @client.quote(params[:symbol])
    @logo = @client.logo(params[:symbol])
    @transaction = current_user.stock_transactions.build
  rescue IEX::Errors::SymbolNotFoundError
    redirect_back(fallback_location: new_search_stock_url, danger: 'Stock not found.')
  end

  def create
    @transaction = current_user.stock_transactions.build(buy_transaction_params)
    @stock = existing_or_new_stock

    ActiveRecord::Base.transaction do
      @transaction.save_buy!
      stock_exists? ? @stock.buy_share!(buy_transaction_params) : @stock.save!
    end
    redirect_to trader_stocks_url, success: "Successfully bought shares of #{@stock.company_name}."
  rescue ActiveRecord::RecordInvalid
    request_iex_quote
    render :new
  end

  private

  def buy_transaction_params
    params.require(:buy_transaction).permit(:symbol, :company_name, :quantity, :unit_price)
  end

  def stock_update
    @stock.buy_share!(buy_transaction_params)
  end

  def stock_exists?
    current_user.stocks.exists?(symbol: params[:buy_transaction][:symbol])
  end

  def existing_or_new_stock
    current_user.stocks.find_by(symbol: params[:buy_transaction][:symbol]) || current_user.stocks.build(buy_transaction_params)
  end

  def request_iex_quote
    request_iex_resource
    @quote = @client.quote(params[:buy_transaction][:symbol])
  end
end
