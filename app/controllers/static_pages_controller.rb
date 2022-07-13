class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :redirect_if_admin

  def home
    @list = Iex::IexMostActiveRequester.perform
  end

  private

  def redirect_if_admin
    redirect_to traders_url if current_user&.admin?
  end
end
