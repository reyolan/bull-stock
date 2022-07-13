require 'rails_helper'
require 'spec_helper'

RSpec.describe "Admin approves pending trader account", type: :request do
  let(:admin) { create(:admin) }
  let!(:trader) { create(:unapproved_unconfirmed_trader) }

  context "when admin is signed in" do
    it "approves pending trader " do
        sign_in admin
        get pending_traders_path
        put approved_trader_path(trader), :params => { :user => {:approved => true} }
        follow_redirect!
        expect(response).to render_template(:index)
        expect(response.body).to include("#{trader.email} has been successfully approved.")
        expect(trader.reload.approved).to eq true
    end
  end
end