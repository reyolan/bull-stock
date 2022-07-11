require 'rails_helper'

RSpec.describe 'View all stock transactions', type: :system do
  let(:approved_trader) { create(:approved_confirmed_trader) }
  let(:unapproved_trader) { create(:unapproved_confirmed_trader) }

  before do
    driven_by(:rack_test)
  end

  context 'when user is approved' do
    let!(:stock_transaction) { create(:buy_transaction, user: approved_trader) }

    it 'shows all stock transactions' do
      sign_in approved_trader

      visit trader_stock_transactions_path

      expect(page).to have_text(stock_transaction.symbol)
      expect(page).to have_text(stock_transaction.company_name)
      expect(page).to have_text(stock_transaction.amount)
    end
  end

  context 'when user is not approved' do
    it 'raises a routing error' do
      sign_in unapproved_trader

      expect { visit trader_stock_transactions_path }.to raise_error(ActionController::RoutingError)
    end
  end
end
