require 'rails_helper'

RSpec.describe 'View all balance transactions of traders', type: :system do
  let(:approved_trader) { create(:approved_confirmed_trader) }
  let(:admin) { create(:admin) }

  context 'when user is an admin' do
    let!(:balance_transaction) { create(:deposit_transaction, user: approved_trader) }
    let!(:another_balance_transaction) { create(:withdraw_transaction, user: approved_trader) }

    it 'shows all balance transactions' do
      sign_in admin

      visit balance_transactions_path

      expect(page).to have_text('Balance Transactions')
      expect(page).to have_text(balance_transaction.amount)
      expect(page).to have_text(balance_transaction.transaction_type.upcase)
      expect(page).to have_text(another_balance_transaction.amount)
      expect(page).to have_text(another_balance_transaction.transaction_type.upcase)
    end
  end

  context 'when user is not an admin' do
    it 'shows a not found page' do
      sign_in approved_trader
      visit balance_transactions_path

      expect(page).to have_text("The page you were looking for doesn't exist.")
    end
  end
end
