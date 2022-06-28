module Traders::SearchStocksHelper
  def new_stock_url_method(stock)
    stock.new_record? ? { url: bought_stocks_url, method: :post } : { url: bought_stock_url, method: :patch }
  end
end
