require 'rails_helper'
require 'spec_helper'

RSpec.describe "Admin adds a trader", type: :request do
  let(:admin) { create(:admin) }
  let(:trader) { create(:approved_confirmed_trader) }

  context "when admin is logged in" do
    it "creates a new user trader account and redirects to traders page" do
      sign_in admin
      get new_trader_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
      @trader ||= FactoryBot.build :approved_unconfirmed_trader
      post traders_path, :params => { :user => {:email => @trader.email, :password => @trader.password, :password_confirmation => @trader.password_confirmation} }
      expect(response).to redirect_to(traders_path)
      follow_redirect!
      expect(response.body).to include("Trader was successfully created.")
    end
  end

  context 'when trader is logged in' do
    it 'shows a not found page' do
      sign_in trader
      get new_trader_path
      expect(response.body).to include("The page you were looking for doesn't exist.")
    end
  end
end

