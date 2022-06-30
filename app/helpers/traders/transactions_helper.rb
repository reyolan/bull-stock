module Traders::TransactionsHelper
  def turn_to_red_or_green(text)
    text == 'buy' ? 'text-green-600' : 'text-red-600'
  end
end
