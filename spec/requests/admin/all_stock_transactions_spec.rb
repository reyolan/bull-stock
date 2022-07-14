require "rails_helper"
require "spec_helper"

RSpec.describe "Admin views all stock transactions", type: :request do
  let(:admin) { create(:admin) }
  let!(:trader) { create(:approved_confirmed_trader) }

  context "when admin is signed in" do
    let!(:stock_transaction) { create(:buy_transaction, user: trader) }
    let!(:another_stock_transaction) { create(:sell_transaction, user: trader) }
    it "views all stock transactions" do
      sign_in admin
      get stock_transactions_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to include(trader.email.to_s)
      expect(response.body).to include(stock_transaction.symbol.to_s)
      expect(response.body).to include(stock_transaction.transaction_type.upcase.to_s)
      expect(response.body).to include(another_stock_transaction.symbol.to_s)
      expect(response.body).to include(another_stock_transaction.transaction_type.upcase.to_s)
    end
  end
end
