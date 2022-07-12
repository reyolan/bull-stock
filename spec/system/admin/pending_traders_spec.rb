require 'rails_helper'

RSpec.describe 'View all traders', type: :system do
  let(:admin) { create(:admin) }
  let!(:approved_trader) { create(:approved_confirmed_trader) }

  context 'when user is an admin' do
    let!(:pending_trader) { create(:unapproved_confirmed_trader) }

    it 'shows all pending traders' do
      sign_in admin

      visit pending_traders_path

      expect(page).to have_text('Pending Traders')
      expect(page).to have_text(pending_trader.email)
      expect(page).not_to have_text(approved_trader.email)
    end
  end

  context 'when user is not an admin' do
    it 'raises a routing error' do
      sign_in approved_trader

      expect { visit traders_path }.to raise_error(ActionController::RoutingError)
    end
  end
end
