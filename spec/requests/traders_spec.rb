require 'rails_helper'

RSpec.describe "Traders", type: :request do
  describe "Uses the trading platform" do
    it "signs up as new user" do
      get new_user_registration_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end
end
