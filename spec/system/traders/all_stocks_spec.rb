require 'rails_helper'

RSpec.describe 'View all stocks', type: :system do
  let(:approved_trader) { create(:approved_confirmed_trader) }
  let(:unapproved_trader) { create(:unapproved_confirmed_trader) }

  before do
    driven_by(:rack_test)
  end

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
