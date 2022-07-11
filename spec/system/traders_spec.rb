require 'rails_helper'

RSpec.describe "Trader User Story", type: :system do
  let(:unapproved_trader) { create(:unapproved_confirmed_trader) }
  let(:approved_trader) { create(:approved_confirmed_trader) }
  let(:trader_with_balance) { create(:trader_with_balance) }

  before do
    driven_by(:rack_test)
  end

  describe 'creation of trader account' do
    context 'with valid details' do
      it 'is successful with email confirmation' do
        visit(new_user_registration_path)

        fill_in 'user_email', with: 'example@example.com'
        fill_in 'user_password', with: '123456'
        fill_in 'user_password_confirmation', with: '123456'

        expect { within('form') { click_on('Sign up') } }.to change(User, :count).by(1)
                                                         .and change(ActionMailer::Base.deliveries, :count).by(1)
      end
    end

    context 'with invalid details' do
      it 'notifies the user that their details is invalid' do
        visit(new_user_registration_path)

        fill_in 'user_email', with: 'example@example.com'
        fill_in 'user_password', with: '12345'
        fill_in 'user_password_confirmation', with: '12345'

        expect { within('form') { click_on('Sign up') } }.not_to(change { User.count })
        expect(page).to have_css('#error_explanation')
      end
    end
  end

  describe 'logging in of credentials to access on the app' do
    context 'with valid credentials' do
      it 'allows user to sign in' do
        visit(new_user_session_path)
        fill_in 'user_email', with: approved_trader.email
        fill_in 'user_password', with: approved_trader.password
        within('form') { click_on('Log in') }

        expect(page).to have_text('Portfolio')
      end
    end

    context 'with invalid credentials' do
      it 'notifies that their credentials is invalid' do
        visit new_user_session_path
        fill_in 'user_email', with: 'example@example.com'
        fill_in 'user_password', with: '123456'
        within('form') { click_on('Log in') }

        expect(page).to have_css('#alert-danger')
      end
    end
  end

  describe 'depositing an amount to have a balance' do
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
    end

    context 'when user is not approved' do
      it 'raises a routing error' do
        sign_in unapproved_trader
        expect { visit trader_balance_path }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe 'buying a stock to add to investment portfolio' do
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

  describe 'having a My Portfolio page to see all stocks' do
    context 'when user is approved' do
      it 'shows portfolio of the user and a link to purchase stock' do
        sign_in approved_trader

        visit trader_stocks_path

        expect(page).to have_link('Purchase Stock')
      end
    end

    context 'when user is not approved' do
      it 'contains message to wait for admin approval and a link to search stock' do
        sign_in unapproved_trader

        visit trader_stocks_path

        expect(page).to have_text('Please wait for admin approval')
        expect(page).to have_link('Search Stock')
      end
    end
  end

  describe 'having a Transaction page to see all stock transactions' do
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

  describe 'selling of stocks to gain money' do
  end
end
