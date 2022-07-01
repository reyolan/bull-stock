class Traders::BalancesController < ApplicationController
  def show
    @balance = current_user.balance
  end
end
