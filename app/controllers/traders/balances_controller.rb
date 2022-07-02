class Traders::BalancesController < ApplicationController
  before_action :authenticate_approved_trader

  def show
    @balance = current_user.balance
  end
end
