require 'rails_helper'

RSpec.describe BalanceTransaction, type: :model do
  it 'has a valid factory' do
    expect(build(:deposit_transaction)).to be_valid
  end
end
