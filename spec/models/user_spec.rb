require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  let(:trader) { build(:approved_confirmed_trader) }

  it 'has a valid factory' do
    expect(trader).to(be_valid)
  end

  describe '#email' do
    it 'is invalid without a value' do
      trader.email = nil
      expect(trader).to_not(be_valid)
    end

    it 'is valid with valid addresses' do
      valid_addresses = %w[example123@example.com EXAMPLE.123@bar.COM ZXCR@foo.bar.org user+123@edu.ph]
      valid_addresses.each do |valid_address|
        trader.email = valid_address
        expect(trader).to(be_valid)
      end
    end

    it 'is invalid with duplicate address' do
      another_trader = build(:approved_confirmed_trader)
      another_trader.email = trader.email
      another_trader.save
      expect(trader).to_not(be_valid)
    end
  end

  describe '#password' do
    it 'is invalid without a value' do
      trader.password = nil
      expect(trader).to_not(be_valid)
    end

    it 'is invalid with less than 6 characters' do
      trader.password = 'abcdef'
      expect(trader).to_not(be_valid)
    end
  end

  describe '#balance' do
    it 'is invalid with negative value' do
      trader.balance = -123
      expect(trader).to_not(be_valid)
    end
  end

  describe '.traders' do
    let(:admin) { create(:admin) }
    let(:trader) { create(:approved_confirmed_trader) }

    it 'includes users with trader role' do
      expect(User.traders).to(include(trader))
    end

    it 'excludes users with admin role' do
      expect(User.traders).to_not(include(admin))
    end
  end

  describe '.pending_traders' do
    let(:unapproved_trader) { create(:unapproved_confirmed_trader) }
    let(:approved_trader) { create(:approved_confirmed_trader) }
    let(:admin) { create(:admin) }

    it 'includes approved users' do
      expect(User.pending_traders).to(include(unapproved_trader))
    end
    it 'excludes approved users' do
      expect(User.pending_traders).to_not(include(approved_trader))
    end
    it 'excludes users with admin role' do
      expect(User.pending_traders).to_not(include(admin))
    end
  end

  describe '.asc_traders' do
    let(:starts_with_t) { create(:approved_confirmed_trader) }
    let(:starts_with_a) { create(:approved_confirmed_trader, email: 'abc@example.com') }

    it 'orders traders ascendingly based on email attribute' do
      expect(User.asc_traders).to(eq([starts_with_a, starts_with_t]))
    end
  end

  describe '#save_approved_trader' do
    let(:unapproved_trader) { build(:unapproved_confirmed_trader) }

    it 'saves user with approved attribute' do
      unapproved_trader.save_approved_trader
      expect(User.first.approved).to(be(true))
    end
  end

  describe '#add_amount' do
    let(:trader) { create(:trader_with_balance) }

    it 'returns user with summed balance' do
      amount_to_add = 200
      expected_balance = trader.balance + amount_to_add
      updated_trader = trader.add_amount(amount_to_add)
      expect(updated_trader.balance).to(eq(expected_balance))
    end
  end

  describe '#subtract_amount' do
    let(:trader) { create(:trader_with_balance) }

    it 'returns user with summed balance' do
      amount_to_subtract = 200
      expected_balance = trader.balance + amount_to_subtract
      updated_trader = trader.add_amount(amount_to_subtract)
      expect(updated_trader.balance).to(eq(expected_balance))
    end
  end

  describe 'after_initialize#set_default_role' do
    it 'initializes new record to trader role' do
      expect(User.new.role).to(eq('trader'))
    end
  end

  describe 'dependent: :destroy' do
    let(:trader) { create(:approved_confirmed_trader) }

    it 'destroys dependent stocks' do
      stock = create(:valid_stock, user: trader)
      trader.destroy
      expect(Stock.all).to_not(include(stock))
    end

    it 'destroys dependent stock transactions' do
      stock_transaction = create(:buy_transaction, user: trader)
      trader.destroy
      expect(StockTransaction.all).to_not(include(stock_transaction))
    end

    it 'destroys dependent balance transactions' do
      balance_transaction = create(:deposit_transaction, user: trader)
      trader.destroy
      expect(BalanceTransaction.all).to_not(include(balance_transaction))
    end
  end
end
