require 'rails_helper'

RSpec.describe 'Show trader', type: :system do
  let(:admin) { create(:admin) }
  let!(:approved_trader) { create(:approved_confirmed_trader) }

  context 'when user is an admin' do
    it 'shows trader details' do
      sign_in admin

      visit trader_path(approved_trader)

      expect(page).to have_text(approved_trader.email)
      expect(page).to have_text('Confirmed')
      expect(page).to have_link(href: edit_trader_path(approved_trader))
    end
  end

  context 'when user is not an admin' do
    it 'shows a not found page' do
      sign_in approved_trader

      visit trader_path(approved_trader)

      expect(page).to have_text("The page you were looking for doesn't exist.")
    end
  end
end
