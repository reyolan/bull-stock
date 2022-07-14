require "rails_helper"

RSpec.describe "Delete trader", type: :system do
  let(:admin) { create(:admin) }
  let!(:trader) { create(:approved_confirmed_trader) }

  context "when user is an admin" do
    it "allows deletion of trader and sends deletion email" do
      sign_in admin

      visit traders_path

      expect {
        accept_confirm do
          click_on "delete"
        end
        sleep(0.5)
      }.to change(User, :count).by(-1).and change(ActionMailer::Base.deliveries, :count).by(1)
      expect(page).to have_css("#alert-success")
    end
  end
end
