class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  add_flash_types :success, :danger

  private

  def after_sign_in_path_for(*)
    current_user.admin? ? traders_path : trader_stocks_path
  end

  def authenticate_trader
    raise ActionController::RoutingError, "Not Found" unless current_user.trader?
  end

  def authenticate_admin
    raise ActionController::RoutingError, "Not Found" unless current_user.admin?
  end

  def authenticate_approved_trader
    raise ActionController::RoutingError, "Not Found" unless current_user.approved? && current_user.trader?
  end
end
