# Trader User Story #7
class Traders::TransactionsController < ApplicationController
  def index
    @transactions = current_user.transactions.order(created_at: :desc)
  end
end
