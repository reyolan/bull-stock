require "rails_helper"

RSpec.describe "Edit trader", type: :system do
  let(:admin) { create(:admin) }
  let!(:approved_trader) { create(:approved_confirmed_trader) }

  context "when user is an admin" do
    it "enables editing of email credentials" do
      sign_in admin

      visit edit_trader_path(approved_trader)

      fill_in "user[email]", with: "approval.trader@example.com"

      click_on "Submit"

      expect(approved_trader.reload.email).to eq("approval.trader@example.com")
    end
  end

  context "when user is not an admin" do
    it "shows a not found page" do
      sign_in approved_trader

      visit edit_trader_path(approved_trader)

      expect(page).to have_text("The page you were looking for doesn't exist.")
    end
  end
end
