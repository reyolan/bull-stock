class Admins::PendingTradersController < ApplicationController
  before_action :authorize_admin

  def index
    @q = User.pending_traders.ransack(params[:q])
    @pending_traders = @q.result.page(params[:page])
  end
end
