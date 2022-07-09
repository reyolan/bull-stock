require 'rails_helper'

RSpec.describe Stock, type: :model do
  let(:stock) { build(:valid_stock) }

  it 'has a valid factory' do
    expect(stock).to be_valid
  end

  describe '#quantity' do
    it 'is invalid with negative quantity' do
      stock.quantity = -12
      expect(stock).to be_invalid
    end
  end

  describe '.overall_amount' do
    let(:saved_stock) { create(:valid_stock) }
    let(:another_saved_stock) { create(:another_valid_stock) }

    it 'sums the amount of all stocks' do
      expected_amount = saved_stock.amount + another_saved_stock.amount
      expect(described_class.overall_amount).to(eq(expected_amount))
    end
  end

  describe '.overall_shares' do
    let(:saved_stock) { create(:valid_stock) }
    let(:another_saved_stock) { create(:another_valid_stock) }

    it 'sums the number of shares of all stocks' do
      expected_overall_shares = saved_stock.quantity + another_saved_stock.quantity
      expect(described_class.overall_shares).to(eq(expected_overall_shares))
    end
  end

  describe '.asc_symbol' do
    let(:stock_symbol_t) { create(:valid_stock) }
    let(:stock_symbol_a) { create(:another_valid_stock) }

    it 'orders ascendingly based on symbol' do
      expect(described_class.asc_symbol).to(eq([stock_symbol_a, stock_symbol_t]))
    end
  end

  describe '#buy_share' do
    let(:existing_stock) { create(:valid_stock) }
    let(:same_stock_to_buy) { build(:stock_with_quantity_unit_price) }
    it 'returns stock with averaged unit price and summed quantity' do
      summed_quantity = same_stock_to_buy.quantity + existing_stock.quantity
      averaged_unit_price = ((existing_stock.unit_price * existing_stock.quantity) +
                             (same_stock_to_buy.unit_price * same_stock_to_buy.quantity)) / 
                            (same_stock_to_buy.quantity + existing_stock.quantity)

      updated_stock = same_stock_to_buy.buy_share(unit_price: same_stock_to_buy.unit_price,
                                                  quantity: same_stock_to_buy.quantity)

      expect(updated_stock.quantity).to(eq(summed_quantity))
      expect(updated_stock.unit_price).to(eq(averaged_unit_price))
    end
  end

  describe '#sell_share' do
    let(:stock_to_sell) { create(:valid_stock) }
    it 'returns stock with subtracted quantity' do
      quantity_to_sell = 2
      subtracted_quantity = stock_to_sell.quantity - quantity_to_sell
      updated_stock = stock_to_sell.sell_share(quantity: quantity_to_sell)
      expect(updated_stock.quantity).to(eq(subtracted_quantity))
    end
  end

  describe 'before_save#total_amount' do
    let(:stock_to_save) { build(:stock_with_quantity_unit_price) }
    it 'sets amount of the stock' do
      expected_amount = stock_to_save.quantity * stock_to_save.unit_price
      stock_to_save.save!
      expect(stock_to_save.amount).to(eq(expected_amount))
    end

    describe 'after_save#destroy_stock' do
      let(:stock) { create(:valid_stock) }

      it 'destroys stock when quantity is zero' do
        stock.quantity = 0
        stock.save!
        expect(described_class.all).to_not(include(stock))
      end
    end
  end
end
