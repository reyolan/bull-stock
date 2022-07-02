module Traders::BuyStockTransactionsHelper
  def max_share(unit_price, balance)
    (balance / unit_price).round(1)
  end
end
