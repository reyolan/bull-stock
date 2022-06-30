module Traders::SellTransactionsHelper
  def check_profit
    profit = @quote.latest_price / @stock.unit_price
    if profit < 1
      "lose $#{profit.round(2)}"
    else
      "gain $#{profit.round(2)}"
    end
  end

  def change_color_if_gain_or_lose
    profit = @quote.latest_price / @stock.unit_price
    if profit < 1
      'text-red-500'
    else
      'text-green-500'
    end
  end
end
