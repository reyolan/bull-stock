# module for helping request specs
module ValidAdminRequestHelper

  # for use in request specs
  def create_trader_by_admin
    @trader ||= FactoryBot.build :trader
    post traders_path, :params => { :user => {:email => @trader.email, :password => @trader.password, :password_confirmation => @trader.password_confirmation} }
  end
end

RSpec.configure do |config|
  config.include ValidAdminRequestHelper, :type => :request
end