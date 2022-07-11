require 'rails_helper'

RSpec.describe 'Buying of stock', type: :system do
  let(:unapproved_trader) { create(:unapproved_confirmed_trader) }
  let(:trader_with_balance) { create(:trader_with_balance) }

  context 'when user is approved' do
    context 'with valid number of shares' do
      it 'adds particular stock to the portfolio of user' do
        sign_in trader_with_balance

        visit new_buy_stock_transaction_path('MSFT')

        fill_in 'buy_transaction[quantity]', with: 5

        expect { click_on 'Purchase Stock' }.to change(trader_with_balance.stocks, :count).by(1)
      end
    end

    context 'with invalid number of shares' do
      it 'notifies the user that the input is invalid' do
        sign_in trader_with_balance

        visit new_buy_stock_transaction_path('MSFT')

        fill_in 'buy_transaction[quantity]', with: -5

        expect { click_on 'Purchase Stock' }.not_to change(trader_with_balance.stocks, :count)
        expect(page).to have_css('#error_explanation')
      end
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
