require 'rails_helper'

RSpec.describe 'Buying of stock', type: :system do
  let(:approved_trader) { create(:approved_confirmed_trader) }
  let(:unapproved_trader) { create(:unapproved_confirmed_trader) }
  let(:trader_with_balance) { create(:trader_with_balance) }

  before do
    driven_by(:rack_test)
  end

  context 'when user is approved' do
    it 'is successful' do
      sign_in trader_with_balance

      visit new_buy_stock_transaction_path('MSFT')

      fill_in 'buy_transaction[quantity]', with: 5

      expect { click_on 'Purchase Stock' }.to change(trader_with_balance.stocks, :count).by(1)
    end
  end

  context 'when user is not approved' do
    it 'contains message to wait for approval' do
      sign_in unapproved_trader

      visit new_buy_stock_transaction_path('MSFT')

      expect(page).not_to have_css('input')
      expect(page).to have_text('Please wait for admin approval')
    end
  end
end
