class Traders::SellStockTransactionsController < ApplicationController
  before_action :authenticate_approved_trader, :request_iex_resource

  def index
    @sell_transactions = current_user.stock_transactions.sell_list
  end

  def new
    @quote = @client.quote(params[:symbol])
    @stock = current_user.stocks.find_by!(symbol: params[:symbol])
    @transaction = current_user.stock_transactions.build
  end

  def create
    @transaction = current_user.stock_transactions.build(sell_transaction_params).sell_type
    @stock = existing_stock
    @current_user_balance = current_user.add_amount(@transaction.amount)

    ActiveRecord::Base.transaction do
      @transaction.save!
      @stock.save!
      @current_user_balance.save!
    end
    redirect_to trader_stocks_url, success: "Successfully sold #{@transaction.quantity} shares of #{@stock.company_name}. 
                                             You earned $#{@transaction.amount}."
  rescue ActiveRecord::RecordInvalid
    request_iex_quote
    render :new
  end

  private

  def existing_stock
    current_user.stocks.find_by!(symbol: params[:sell_transaction][:symbol]).sell_share(sell_transaction_params)
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
