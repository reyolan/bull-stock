class Traders::SearchStocksController < ApplicationController
  before_action :request_iex_resource

  def new; end

  def create
    redirect_to "/search_stocks/#{params[:symbol]}"
  end

  def show
    @quote = @client.quote(params[:symbol])
  end
end
