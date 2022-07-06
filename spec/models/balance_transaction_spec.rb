require 'rails_helper'

RSpec.describe BalanceTransaction, type: :model do
  it 'has a valid factory' do
    expect(build(:deposit_transaction)).to be_valid
  end

  it 'is invalid without association to a user' do
    balance_transaction = build(:deposit_transaction, user_id: nil)
    balance_transaction.valid?
    expect(balance_transaction.errors[:user]).to include('must exist')
  end

  it 'is invalid with amount scaling to three or more' do
    balance_transaction = build(:deposit_transaction, amount: 2.225)
    balance_transaction.valid?
    expect(balance_transaction.errors[:base]).to include('You can only input amount up to scale of 2 (e.g. 20, 20.3, 20.25)')
  end

  it 'is invalid with negative amount' do
    balance_transaction = build(:deposit_transaction, amount: -12)
    balance_transaction.valid?
    expect(balance_transaction.errors[:base]).to include('An input of negative amount is not possible')
  end

  it 'is invalid with amount of zero' do 
    balance_transaction = build(:deposit_transaction, amount: 0)
    balance_transaction.valid?
    expect(balance_transaction.errors[:base]).to include('Please input a valid amount')
  end
end
