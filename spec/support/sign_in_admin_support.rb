# module for helping request specs
module ValidAdminRequestHelper

  # for use in request specs
  def sign_in_as_a_valid_admin
    @admin ||= FactoryBot.create :user
    sign_in @admin
  end
end

RSpec.configure do |config|
  config.include ValidAdminRequestHelper, :type => :request
end