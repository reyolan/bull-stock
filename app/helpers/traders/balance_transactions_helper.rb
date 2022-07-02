module Traders::BalanceTransactionsHelper
  def turn_to_red_or_green(text)
    text == 'deposit' ? 'text-green-600' : 'text-red-600'
  end
end
