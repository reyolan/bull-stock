require "rails_helper"

RSpec.describe "View all traders", type: :system do
  let(:admin) { create(:admin) }
  let!(:approved_trader) { create(:approved_confirmed_trader) }

  context "when user is an admin" do
    it "shows all traders" do
      sign_in admin

      visit traders_path

      expect(page).to have_text("Traders")
      expect(page).to have_text(approved_trader.email)
      expect(page).to have_link(href: trader_path(approved_trader))
      expect(page).to have_link(href: edit_trader_path(approved_trader))
      expect(page).to have_link(href: trader_path(approved_trader))
    end
  end

  context "when user is not an admin" do
    it "shows a not found page" do
      sign_in approved_trader
      visit traders_path

      expect(page).to have_text("The page you were looking for doesn't exist.")
    end
  end
end
