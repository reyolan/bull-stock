# module for helping request specs
module ValidAdminRequestHelper

  # for use in request specs
  def sign_in_as_a_valid_admin
    @admin ||= FactoryBot.create :user
    post_via_redirect user_session_path, 'user[email]' => @admin.email, 'user[password]' => @admin.password
  end
end

RSpec.configure do |config|
  config.include ValidAdminRequestHelper, :type => :request
end