require 'rails_helper'

RSpec.describe 'Deposit amount to increase balance', type: :system do
  let(:approved_trader) { create(:approved_confirmed_trader) }
  let(:unapproved_trader) { create(:unapproved_confirmed_trader) }

  before do
    driven_by(:rack_test)
  end

  context 'when user is approved' do
    context 'with valid amount' do
      it 'is successful' do
        sign_in approved_trader

        visit new_deposit_balance_transaction_path

        fill_in 'deposit_transaction[amount]', with: 5000

        click_on 'Confirm Deposit'

        expect { approved_trader.reload }.to change(approved_trader, :balance).by(5000)
      end
    end

    context 'with invalid amount' do
      it 'notifies user that the amount is invalid' do
        sign_in approved_trader

        visit new_deposit_balance_transaction_path

        fill_in 'deposit_transaction[amount]', with: -1234

        click_on 'Confirm Deposit'

        expect { approved_trader.reload }.not_to change(approved_trader, :balance)
        expect(page).to have_css('#error_explanation')
      end
    end
    context 'when user is not approved' do
      it 'raises a routing error' do
        sign_in unapproved_trader
        expect { visit trader_balance_path }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
