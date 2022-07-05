class Traders::BuyStockTransactionsController < ApplicationController
  before_action :authenticate_trader

  def index
    @buy_transactions = current_user.stock_transactions.buy_list.page(params[:page])
  end

  def new
    request_iex_quote_and_logo(params[:symbol])
    store_stock_quote_to_buy
    @transaction = current_user.stock_transactions.build
  rescue IEX::Errors::SymbolNotFoundError
    redirect_back(fallback_location: new_search_stock_url, danger: 'Stock not found.')
  end

  def create
    @transaction = current_user.stock_transactions.build(buy_transaction_params).buy
    @stock = existing_or_new_stock_of_current_user
    @current_user_balance = current_user.subtract_amount(@transaction.amount)
    ActiveRecord::Base.transaction do
      @transaction.save!
      @stock.save!
      @current_user_balance.save!
    end
    redirect_to trader_stocks_url, success: "Successfully bought #{@transaction.quantity}
                                             shares of #{@stock.company_name}."
  rescue ActiveRecord::RecordInvalid
    request_iex_quote_and_logo(session[:stock]['symbol'])
    store_stock_quote_to_buy
    render :new
  end

  private

  def existing_or_new_stock_of_current_user
    current_user.stocks.find_by(symbol: session[:stock]['symbol'])&.buy_share(buy_transaction_params) ||
      current_user.stocks.build(buy_transaction_params)
  end

  def buy_transaction_params
    params.require(:buy_transaction).permit(:quantity).merge(session[:stock])
  end

  def request_iex_quote_and_logo(params)
    request_iex_resource
    @quote = @client.quote(params)
    @logo = @client.logo(params)
  end

  def store_stock_quote_to_buy
    session[:stock] = { company_name: @quote.company_name, symbol: @quote.symbol, unit_price: @quote.latest_price }
  end
end
