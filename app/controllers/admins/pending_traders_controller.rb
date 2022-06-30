# Admin User Stories #5 and #6
class Admins::PendingTradersController < ApplicationController
  before_action :authenticate_admin
  
  def index
    # User Story #5
    # User.all.where(approved: :false)
    @pending_traders = User.where(role: "trader", approved: :false)
  end
end
