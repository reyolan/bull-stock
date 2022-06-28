class Traders::SearchStocksController < ApplicationController
  before_action :request_iex_resource

  def new; end

  def create
    redirect_to "/search_stocks/#{params[:symbol]}"
  end

  def show
    @quote = @client.quote(params[:symbol])
    # find if meron existing record yung @stock, if alaws, ibuild lang
    @stock = current_user.stocks.find_by(symbol: params[:symbol]) || current_user.stocks.build
  rescue IEX::Errors::SymbolNotFoundError
    redirect_back(fallback_location: new_search_stock_url, danger: 'Stock not found.')
  end
end
