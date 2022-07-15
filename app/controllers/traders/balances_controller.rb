class Traders::BalancesController < ApplicationController
  before_action :authorize_approved_trader

  def show
    @balance = current_user.balance
  end
end
