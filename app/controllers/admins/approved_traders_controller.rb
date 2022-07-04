class Admins::ApprovedTradersController < ApplicationController
  before_action :authenticate_admin

  def update
    trader = User.find(params[:id])
    trader.update(approved: true)
    UserMailer.with(user: trader).account_approval_email.deliver_later
    redirect_back(fallback_location: traders_url, success: "#{trader.email} has been successfully approved.")
  end
end
