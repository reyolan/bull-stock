class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
  request_iex_most_traded_stocks
  end

  private


  def request_iex_most_traded_stocks
  client = IEX::Api::Client.new
  @list = client.stock_market_list(:mostactive)
  end

end
