require 'rails_helper'

RSpec.describe "Trader User Story", type: :system do
  let(:unapproved_trader) { create(:unapproved_confirmed_trader) }
  let(:approved_trader) { create(:approved_confirmed_trader) }

  before do
    driven_by(:rack_test)
  end

  describe 'creation of trader account to buy and sell stocks' do
    it 'is successful with confirmation email' do
      visit(new_user_registration_path)

      fill_in 'user_email', with: 'example@example.com'
      fill_in 'user_password', with: '123456'
      fill_in 'user_password_confirmation', with: '123456'

      expect { within('form') { click_on('Sign up') } }.to change(User, :count).by(1)
                                                       .and change(ActionMailer::Base.deliveries, :count).by(1)
    end

    it 'is unsuccessful due to invalid details' do
      visit(new_user_registration_path)

      fill_in 'user_email', with: 'example@example.com'
      fill_in 'user_password', with: '12345'
      fill_in 'user_password_confirmation', with: '12345'

      expect { within('form') { click_on('Sign up') } }.not_to(change { User.count })
      expect(page).to have_css('#error_explanation')
    end
  end

  describe 'logging in of credentials to access on the app' do
    it 'is successful' do
      visit(new_user_session_path)
      fill_in 'user_email', with: approved_trader.email
      fill_in 'user_password', with: approved_trader.password
      within('form') { click_on('Log in') }

      expect(page).to have_text('Portfolio')
    end

    it 'is unsuccessful due to invalid credentials' do
      visit new_user_session_path
      fill_in 'user_email', with: 'example@example.com'
      fill_in 'user_password', with: '123456'
      within('form') { click_on('Log in') }

      expect(page).to have_css('#alert-danger')
    end
  end

  describe 'depositing an amount to have a balance' do
    it 'is successful when user is approved' do
      sign_in approved_trader

      visit new_deposit_balance_transaction_path

      fill_in 'deposit_transaction[amount]', with: 5000

      click_on 'Confirm Deposit'

      expect { approved_trader.reload }.to change(approved_trader, :balance).by(5000)
    end

    it 'is unsuccessful when user is not approved' do
      # sign_in unapproved_trader
      # expect { visit trader_balance_path }.to raise_error(ActionController::RoutingError)
    end
  end

  describe 'buying a stock to add to investment portfolio' do
    it 'is successful when user is approved' do
      # sign_in approved_trader
    end

    it 'is unsuccessful when user is not approved' do
    end
  end

  describe 'having a My Portfolio page to see all stocks' do
  end
end
