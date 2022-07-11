require 'rails_helper'

RSpec.describe 'Selling of stock', type: :system do
  let(:approved_trader) { create(:approved_confirmed_trader) }
  let(:stock) { create(:valid_stock, user: approved_trader) }

  context 'with sufficient number of shares' do
    it 'adds balance equivalent to the sold stock amount' do
      VCR.use_cassette('msft_stock') do
        sign_in approved_trader

        visit new_sell_stock_transaction_path(stock.symbol)

        fill_in 'sell_transaction[quantity]', with: stock.quantity

        click_on 'Sell a Share'

        expect { approved_trader.reload }.to change(approved_trader, :balance)
      end
    end
  end

  context 'with invalid number of shares' do
    it 'notifies the user that the input is invalid' do
      VCR.use_cassette('msft_stock') do
        sign_in approved_trader

        visit new_sell_stock_transaction_path(stock.symbol)

        fill_in 'sell_transaction[quantity]', with: -5

        click_on 'Sell a Share'

        expect { approved_trader.reload }.not_to change(approved_trader, :balance)
        expect(page).to have_css('#error_explanation')
      end
    end
  end

  context 'without ownership of shares' do
    it 'raises record not found error' do
      sign_in approved_trader

      expect { visit new_sell_stock_transaction_path('AMZN') }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
