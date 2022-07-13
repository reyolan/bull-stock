class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    @list = Iex::IexMostActiveRequester.perform
  end
end
