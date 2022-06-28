module Traders::SearchStocksHelper
  def check_if_new_url(stock)
    stock.new_record? ? bought_stocks_path : bought_stock_path
  end

  def check_if_new_method(stock)
    stock.new_record? ? :post : :patch
  end
end
