require 'rails_helper'

RSpec.describe 'Add trader', type: :system do
  let(:admin) { create(:admin) }
  let(:trader_to_create) { build(:unapproved_unconfirmed_trader) }
  let(:approved_trader) { create(:approved_confirmed_trader) }

  context 'when user is an admin' do
    it 'allows creation of trader account' do
      sign_in admin

      visit new_trader_path

      fill_in 'user[email]', with: trader_to_create.email
      fill_in 'user[password]', with: trader_to_create.password
      fill_in 'user[password_confirmation]', with: trader_to_create.password

      expect { within('form') { click_on 'Create Trader Account' } }.to change(User, :count).by(1)
                                                                    .and change(ActionMailer::Base.deliveries, :count)
                                                                    .by(1)
    end
  end

  context 'when user is not an admin' do
    it 'shows a not found page' do
      sign_in approved_trader

      visit new_trader_path

      expect(page).to have_text("The page you were looking for doesn't exist.")
    end
  end
end
