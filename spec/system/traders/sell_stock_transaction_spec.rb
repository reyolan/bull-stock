# require 'rails_helper'

# RSpec.describe 'Selling of stock', type: :system do
#   let(:approved_trader) { create(:approved_confirmed_trader) }
#   let!(:stock) { create(:valid_stock, user: approved_trader) }

#   context 'with sufficient number of shares' do
#     it 'adds balance equivalent to the sold stock amount' do
#       sign_in approved_trader

#       visit new_sell_stock_transaction_path(stock.symbol)

#       fill_in 'sell_transaction[quantity]', with: stock.quantity

#       click_on 'Sell a share'

#       expect { approved_trader.balance }.to.positive?
#     end
#   end

#   context 'with invalid number of shares' do
#     it 'notifies the user that the input is invalid' do
#       sign_in approved_trader

#       visit new_sell_stock_transaction_path(stock.symbol)

#       fill_in 'sell_transaction[quantity]', with: -5

#       expect { click_on 'Sell a share' }.not_to change(approved_trader, :balance)
#       expect(page).to have_css('#error_explanation')
#     end
#   end
# end
