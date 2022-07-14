class Traders::BuyStockTransactionsController < ApplicationController
  before_action :authenticate_trader

  def index
    @buy_transactions = current_user.stock_transactions.buy_list.page(params[:page])
  end

  def new
    @result = Iex::IexQuoteLogoRequester.new(params[:symbol]).perform
    if @result.success?
      @transaction = current_user.stock_transactions.build
      session[:stock] = {company_name: @result.quote.company_name, symbol: @result.quote.symbol,
                          unit_price: @result.quote.latest_price}
    else
      redirect_back(fallback_location: new_search_stock_url, danger: "#{@result.message}.")
    end
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
                                             share/s of #{@stock.company_name}."
  rescue ActiveRecord::RecordInvalid
    handle_record_invalid_exception
  end

  private

  def buy_transaction_params
    params.require(:buy_transaction).permit(:quantity).merge(session[:stock])
  end

  def existing_or_new_stock_of_current_user
    current_user.stocks.find_by(symbol: session[:stock]["symbol"])&.buy_share(buy_transaction_params) ||
      current_user.stocks.build(buy_transaction_params)
  end

  def handle_record_invalid_exception
    @result = Iex::IexQuoteLogoRequester.new(session[:stock]["symbol"]).perform
    session[:stock] = {company_name: @result.quote.company_name, symbol: @result.quote.symbol,
                        unit_price: @result.quote.latest_price}
    render :new
  end
end
