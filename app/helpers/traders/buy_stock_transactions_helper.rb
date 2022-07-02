module Traders::BuyStockTransactionsHelper
  def max_share(unit_price, balance)
    (balance / unit_price).truncate(1)
  end
end
