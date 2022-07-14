require "rails_helper"
require "spec_helper"

RSpec.describe "Admin views pending traders account", type: :request do
  let(:admin) { create(:admin) }
  let!(:trader1) { create(:unapproved_unconfirmed_trader) }
  let!(:trader2) { create(:unapproved_unconfirmed_trader) }

  context "when admin is signed in" do
    it "views all traders that registered in the app" do
      sign_in admin
      get pending_traders_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to include("Pending Traders")
      expect(response.body).to include(trader1.email.to_s)
      expect(response.body).to include(trader2.email.to_s)
    end
  end
end
