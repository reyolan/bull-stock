require 'rails_helper'

RSpec.describe StockTransaction, type: :model do
  it 'has a valid factory' do
    expect(build(:buy_transaction)).to be_valid
  end

  describe '#quantity' do
    let(:stock_transaction) { build(:buy_transaction) }

    it 'is invalid with quantity scaling to two or more' do
      stock_transaction.quantity = 2.22
      expect(stock_transaction).to be_invalid
    end

    it 'is invalid with negative quantity' do
      stock_transaction.quantity = -12
      expect(stock_transaction).to be_invalid
    end

    it 'is invalid with quantity of zero' do
      stock_transaction.quantity = 0
      expect(stock_transaction).to be_invalid
    end
  end

  describe '.buy_list' do
    let(:buy_list) { StockTransaction.buy_list }
    let(:buy) { create(:buy_transaction) }
    let(:yesterday_buy) { create(:yesterday_buy_transaction) }
    let(:sell) { create(:sell_transaction) }

    it 'includes stock transactions with buy transaction type' do
      expect(buy_list).to(include(buy, yesterday_buy))
    end

    it 'excludes stock transactions with sell transaction type' do
      expect(buy_list).to_not(include(sell))
    end

    it 'orders descendingly based on created_at' do
      expect(buy_list).to(eq([buy, yesterday_buy]))
    end
  end

  describe '.sell_list' do
    let(:sell_list) { StockTransaction.sell_list }
    let(:sell) { create(:sell_transaction) }
    let(:yesterday_sell) { create(:yesterday_sell_transaction) }
    let(:buy) { create(:buy_transaction) }

    it 'includes stock transactions with sell transaction type' do
      expect(sell_list).to(include(sell, yesterday_sell))
    end

    it 'excludes stock transactions with buy transaction type' do
      expect(sell_list).to_not(include(buy))
    end

    it 'orders descendingly based on created_at' do
      expect(sell_list).to(eq([sell, yesterday_sell]))
    end
  end

  describe '#buy' do
    let(:stock_transaction) { build(:stock_transaction) }
    it 'returns stock transaction with computed amount and buy transaction type' do
      stock_transaction.buy
      computed_amount = stock_transaction.unit_price * stock_transaction.quantity
      expect(stock_transaction.transaction_type).to(eq('buy'))
      expect(stock_transaction.amount).to(eq(computed_amount))
    end
  end

  describe '#sell' do
    let(:stock_transaction) { build(:stock_transaction) }
    it 'returns stock transaction with computed amount and sell transaction type' do
      stock_transaction.sell
      computed_amount = stock_transaction.unit_price * stock_transaction.quantity
      expect(stock_transaction.transaction_type).to(eq('sell'))
      expect(stock_transaction.amount).to(eq(computed_amount))
    end
  end
end
