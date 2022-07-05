class Traders::SellStockTransactionsController < ApplicationController
  before_action :authenticate_approved_trader

  def index
    @sell_transactions = current_user.stock_transactions.sell_list.page(params[:page])
  end

  def new
    @stock = current_user.stocks.find_by!(symbol: params[:symbol])
    request_iex_quote_and_logo(params[:symbol])
    store_stock_quote_to_sell
    @transaction = current_user.stock_transactions.build
  end

  def create
    @transaction = current_user.stock_transactions.build(sell_transaction_params).sell
    @stock = current_user.stocks.find_by!(symbol: session[:stock]['symbol'])
                         .sell_share(sell_transaction_params)
    @current_user_balance = current_user.add_amount(@transaction.amount)

    ActiveRecord::Base.transaction do
      @transaction.save!
      @stock.save!
      @current_user_balance.save!
    end
    redirect_to trader_stocks_url, success: "Successfully sold #{@transaction.quantity} shares of #{@stock.company_name}.
                                             You received $#{@transaction.amount}."
  rescue ActiveRecord::RecordInvalid
    request_iex_quote_and_logo(session[:stock]['symbol'])
    store_stock_quote_to_sell
    render :new
  end

  private

  def sell_transaction_params
    params.require(:sell_transaction).permit(:quantity).merge(session[:stock])
  end

  def store_stock_quote_to_sell
    session[:stock] = { company_name: @quote.company_name,
                        symbol: @quote.symbol, unit_price: @quote.latest_price }.symbolize_keys!
  end

  def request_iex_quote_and_logo(params)
    request_iex_resource
    @quote = @client.quote(params)
    @logo = @client.logo(params)
  end
end
