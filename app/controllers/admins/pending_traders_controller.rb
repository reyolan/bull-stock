# Admin User Stories #5 and #6
class Admins::PendingTradersController < ApplicationController
  def index
    # User Story #5
    # User.all.where(approved: :false)
  end

  def destroy
    # Admin User Story #6
    # Trader User Story #4
    # We can think of this as removing/destroying the pending state of the trader
  end
end
