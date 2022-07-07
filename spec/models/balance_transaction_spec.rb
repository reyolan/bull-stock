require 'rails_helper'

RSpec.describe BalanceTransaction, type: :model do
  it 'has a valid factory' do
    expect(build(:deposit_transaction)).to be_valid
  end

  it 'is invalid without association to a user' do
    balance_transaction = build(:deposit_transaction, user_id: nil)
    balance_transaction.valid?
    expect(balance_transaction.errors[:user]).to(include('must exist'))
  end

  it 'is invalid with amount scaling to three or more' do
    balance_transaction = build(:deposit_transaction, amount: 2.225)
    balance_transaction.valid?
    expect(balance_transaction.errors[:base]).to(include('You can only input amount up to scale of 2 (e.g. 20, 20.3, 20.25)'))
  end

  it 'is invalid with negative amount' do
    balance_transaction = build(:deposit_transaction, amount: -12)
    balance_transaction.valid?
    expect(balance_transaction.errors[:base]).to(include('An input of negative amount is not possible'))
  end

  it 'is invalid with amount of zero' do
    balance_transaction = build(:deposit_transaction, amount: 0)
    balance_transaction.valid?
    expect(balance_transaction.errors[:base]).to(include('Please input a valid amount'))
  end

  describe '.deposits' do
    before do
      @deposit = create(:deposit_transaction)
      @yesterday_deposit = create(:yesterday_deposit_transaction)
      @withdraw = create(:withdraw_transaction)
    end

    it 'includes balance transactions with deposit transaction type' do
      expect(BalanceTransaction.deposits).to(include(@deposit, @yesterday_deposit))
    end

    it 'has a descending order based on created_at' do
      expect(BalanceTransaction.deposits.first).to(eq(@deposit))
    end

    it 'excludes balance transactions without deposit transaction type' do
      expect(BalanceTransaction.deposits).not_to(include(@withdraw))
    end
  end

  describe '.withdrawals' do
    before do
      @deposit = create(:deposit_transaction)
      @withdraw = create(:withdraw_transaction)
      @yesterday_withdraw = create(:yesterday_withdraw_transaction)
    end

    it 'includes balance transactions with withdrawal type' do
      expect(BalanceTransaction.withdrawals).to(include(@withdraw, @yesterday_withdraw))
    end

    it 'orders the collection in descending order based on created_at attribute' do
      expect(BalanceTransaction.withdrawals.first).to(eq(@withdraw))
    end

    it 'excludes balance transaction without withdraw transaction type' do
      expect(BalanceTransaction.withdrawals).not_to(include(@deposit))
    end
  end

  describe '.desc_created_at' do
    before do
      @today_transaction = create(:withdraw_transaction)
      @yesterday_transaction = create(:yesterday_withdraw_transaction)
    end

    it 'orders the collection in descending order based on created_at attribute' do
      expect(BalanceTransaction.first).to(eq(@today_transaction))
    end
  end
end
