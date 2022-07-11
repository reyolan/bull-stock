require 'rails_helper'

RSpec.describe 'Trader login', type: :system do
  let(:approved_trader) { create(:approved_confirmed_trader) }

  context 'with valid credentials' do
    it 'allows user to sign in' do
      visit new_user_session_path
      fill_in 'user_email', with: approved_trader.email
      fill_in 'user_password', with: approved_trader.password
      within('form') { click_on('Log in') }

      expect(page).to have_current_path(trader_stocks_path)
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
