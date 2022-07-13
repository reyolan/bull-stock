require 'rails_helper'
require 'spec_helper'

RSpec.describe "Admin edits trader details", type: :request do
  let(:admin) { create(:admin) }
  let(:trader) {create(:approved_confirmed_trader)}

  context "when admin is logged in" do
    it "edits a user trader account and redirects to traders page" do
        sign_in admin
        get edit_trader_path(trader)
        expect(response).to render_template(:edit)
        put trader_path, :params => { :user => {:email => "editted@email.com"}}
        follow_redirect!
        expect(response).to render_template(:index)
        expect(response.body).to include('Trader details was successfully updated.')
        expect(trader.reload.email).to eq "editted@email.com"
    end
  end
end