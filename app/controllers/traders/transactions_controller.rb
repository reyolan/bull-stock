class Traders::TransactionsController < ApplicationController
  before_action :authenticate_trader
  
  def index
    @transactions = current_user.transactions.order(created_at: :desc)
  end
end
