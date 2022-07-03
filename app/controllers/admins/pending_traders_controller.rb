class Admins::PendingTradersController < ApplicationController
  before_action :authenticate_admin

  def index
    @q = User.where(role: 'trader', approved: false).ransack(params[:q])
    @pending_traders = @q.result
  end
end
