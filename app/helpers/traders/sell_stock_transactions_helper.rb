module Traders::SellStockTransactionsHelper
  def check_profit
    profit = @stock.unit_price - @result.quote.latest_price
    if profit < 1
      "lose $#{profit.round(2).abs}"
    else
      "gain $#{profit.round(2)}"
    end
  end

  def change_color_if_gain_or_lose
    profit = @stock.unit_price - @result.quote.latest_price
    if profit < 1
      "text-red-500"
    else
      "text-green-500"
    end
  end
end
