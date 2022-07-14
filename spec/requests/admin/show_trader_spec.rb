require "rails_helper"
require "spec_helper"

RSpec.describe "Admin views trader account", type: :request do
  let(:admin) { create(:admin) }
  let(:trader) { create(:approved_confirmed_trader) }

  context "when admin is signed in" do
    it "views specific trader account" do
      sign_in admin
      get trader_path(trader)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
      expect(response.body).to include(trader.email.to_s)
    end
  end
end
