require 'rails_helper'

RSpec.describe "Trader User Story", type: :system do
  let(:unapproved_trader) { create(:unapproved_confirmed_trader) }
  let(:approved_trader) { create(:approved_confirmed_trader) }
  let(:trader_with_balance) { create(:trader_with_balance) }

  before do
    driven_by(:rack_test)
  end

  describe 'selling of stocks to gain money' do
  end
end
