class Traders::BuyStockTransactionsController < ApplicationController
  before_action :authenticate_trader, :request_iex_resource

  def index
    @buy_transactions = current_user.stock_transactions.buy_list.page(params[:page])
  end

  def new
    request_iex_quote_and_logo(params[:symbol])
    @transaction = current_user.stock_transactions.build
  rescue IEX::Errors::SymbolNotFoundError
    redirect_back(fallback_location: new_search_stock_url, danger: 'Stock not found.')
  end

  def create
    @transaction = current_user.stock_transactions.build(buy_transaction_params).buy
    @stock = existing_or_new_stock
    @current_user_balance = current_user.subtract_amount(@transaction.amount)
    ActiveRecord::Base.transaction do
      @transaction.save!
      @stock.save!
      @current_user_balance.save!
    end
    redirect_to trader_stocks_url, success: "Successfully bought #{@transaction.quantity} shares of #{@stock.company_name}."
  rescue ActiveRecord::RecordInvalid
    request_iex_quote_and_logo(params[:buy_transaction][:symbol])
    render :new
  end

  private

  def existing_or_new_stock
    current_user.stocks.find_by(symbol: params[:buy_transaction][:symbol])&.buy_share(buy_transaction_params) ||
      current_user.stocks.build(buy_transaction_params)
  end

  def buy_transaction_params
    params.require(:buy_transaction).permit(:symbol, :company_name, :quantity, :unit_price)
  end

  def request_iex_quote_and_logo(params)
    request_iex_resource
    @quote = @client.quote(params)
    @logo = @client.logo(params)
  end
end
