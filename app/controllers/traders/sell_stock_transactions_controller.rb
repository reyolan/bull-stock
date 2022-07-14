class Traders::SellStockTransactionsController < ApplicationController
  before_action :authenticate_approved_trader

  def index
    @sell_transactions = current_user.stock_transactions.sell_list.page(params[:page])
  end

  def new
    @stock = current_user.stocks.find_by!(symbol: params[:symbol])
    @result = Iex::IexQuoteLogoRequester.new(params[:symbol]).perform
    @transaction = current_user.stock_transactions.build
    session[:stock] = {company_name: @result.quote.company_name, symbol: @result.quote.symbol,
                        unit_price: @result.quote.latest_price}
  end

  def create
    @transaction = current_user.stock_transactions.build(sell_transaction_params).sell
    @stock = current_user.stocks.find_by!(symbol: session[:stock]["symbol"])
      .sell_share(sell_transaction_params)
    @current_user_balance = current_user.add_amount(@transaction.amount)

    ActiveRecord::Base.transaction do
      @transaction.save!
      @stock.save!
      @current_user_balance.save!
    end
    redirect_to trader_stocks_url, success: "Successfully sold #{@transaction.quantity} share/s of #{@stock.company_name}.
                                             You received $#{@transaction.amount}."
  rescue ActiveRecord::RecordInvalid
    handle_record_invalid_exception
  end

  private

  def sell_transaction_params
    params.require(:sell_transaction).permit(:quantity).merge(session[:stock])
  end

  def handle_record_invalid_exception
    @result = Iex::IexQuoteLogoRequester.new(session[:stock]["symbol"]).perform
    session[:stock] = {company_name: @result.quote.company_name, symbol: @result.quote.symbol,
                        unit_price: @result.quote.latest_price}
    render :new
  end
end
