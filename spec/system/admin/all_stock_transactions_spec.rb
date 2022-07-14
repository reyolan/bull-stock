require 'rails_helper'

RSpec.describe 'View all stock transactions of traders', type: :system do
  let(:approved_trader) { create(:approved_confirmed_trader) }
  let(:admin) { create(:admin) }

  context 'when user is an admin' do
    let!(:stock_transaction) { create(:buy_transaction, user: approved_trader) }
    let!(:another_stock_transaction) { create(:sell_transaction, user: approved_trader) }

    it 'shows all stock transactions' do
      sign_in admin

      visit stock_transactions_path

      expect(page).to have_text('Stock Transactions')
      expect(page).to have_text(stock_transaction.amount)
      expect(page).to have_text(stock_transaction.transaction_type.upcase)
      expect(page).to have_text(another_stock_transaction.amount)
      expect(page).to have_text(another_stock_transaction.transaction_type.upcase)
    end
  end

  context 'when user is not an admin' do
    it 'shows a not found page' do
      sign_in approved_trader
      visit stock_transactions_path

      expect(page).to have_text("The page you were looking for doesn't exist.")
    end
  end
end
