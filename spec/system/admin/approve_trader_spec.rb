require 'rails_helper'

RSpec.describe 'Approve trader', type: :system do
  let(:admin) { create(:admin) }
  let!(:unapproved_trader) { create(:unapproved_confirmed_trader) }

  context 'when user is an admin' do
    it 'allows approval of trader and sends approval email' do
      sign_in admin

      visit pending_traders_path

      expect { click_on 'Approve' }.to change(ActionMailer::Base.deliveries, :count).by(1)

      expect(unapproved_trader.reload.approved?).to be(true)
    end
  end
end
