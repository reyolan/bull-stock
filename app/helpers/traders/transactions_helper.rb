module Traders::TransactionsHelper
  def display_purchase_or_search_stock
    current_user.approved? ? 'Purchase Stock' : 'Search Stock'
  end
end
