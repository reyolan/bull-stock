require 'rails_helper'

RSpec.describe 'Searching of stock', type: :system do
  let(:approved_trader) { create(:approved_confirmed_trader) }
  let(:unapproved_trader) { create(:unapproved_confirmed_trader) }
  let(:admin) { create(:admin) }

  context 'when user is a trader' do
    context 'with approved status' do
      it 'shows the searched stock and purchase stock link' do
        VCR.use_cassette('msft_stock') do
          sign_in approved_trader

          visit new_search_stock_path

          fill_in 'symbol', with: 'MSFT'

          click_on 'Purchase Stock'

          expect(page).to have_text('Company Name')
          expect(page).to have_text('Price')
          expect(page).to have_css('input')
        end
      end
    end

    context 'with unapproved status' do
      it 'shows the searched stock and admin approval notification' do
        VCR.use_cassette('msft_stock') do
          sign_in unapproved_trader

          visit new_search_stock_path

          fill_in  'symbol', with: 'MSFT'

          click_on 'Search Stock'

          expect(page).to have_text('Company Name')
          expect(page).to have_text('Price')
          expect(page).to have_text('Please wait for admin approval')
        end
      end
    end
  end

  context 'when user is an admin' do
    it 'raises a routing error' do
      sign_in admin

      expect { visit new_search_stock_path }.to raise_error(ActionController::RoutingError)
    end
  end
end