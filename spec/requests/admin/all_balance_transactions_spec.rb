require 'rails_helper'
require 'spec_helper'

RSpec.describe "Admin views all balance transactions", type: :request do
  let(:admin) { create(:admin) }
  let!(:trader) { create(:approved_confirmed_trader) }


  context "when admin is signed in" do
    let!(:balance_transaction) { create(:deposit_transaction, user: trader) }
    let!(:another_balance_transaction) { create(:withdraw_transaction, user: trader) }
    it "views all balance transactions" do
        sign_in admin
        get balance_transactions_path
        expect(response).to have_http_status(200)
        expect(response).to render_template(:index)
        expect(response.body).to include("#{trader.email}")
        expect(response.body).to include("#{balance_transaction.amount}")
        expect(response.body).to include("#{another_balance_transaction.amount}")
    end
  end
end