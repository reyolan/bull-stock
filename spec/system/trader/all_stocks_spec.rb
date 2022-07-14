require "rails_helper"

RSpec.describe "View all stocks", type: :system do
  let(:approved_trader) { create(:trader_with_balance) }
  let(:unapproved_trader) { create(:unapproved_confirmed_trader) }
  let(:admin) { create(:admin) }

  context "when user is approved" do
    let!(:purchased_stock) { create(:valid_stock, user: approved_trader) }

    it "shows portfolio of the user and a link to purchase stock" do
      sign_in approved_trader

      visit trader_stocks_path

      expect(page).to have_link("Purchase Stock")
      expect(page).to have_text(purchased_stock.symbol)
      expect(page).to have_text(purchased_stock.company_name)
      expect(page).to have_text(purchased_stock.quantity)
    end
  end

  context "when user is not approved" do
    it "contains message to wait for admin approval and a link to search stock" do
      sign_in unapproved_trader

      visit trader_stocks_path

      expect(page).to have_text("Please wait for admin approval")
      expect(page).to have_link("Search Stock")
    end
  end

  context "when user is an admin" do
    it "shows a not found page" do
      sign_in admin

      visit trader_stocks_path

      expect(page).to have_text("The page you were looking for doesn't exist.")
    end
  end
end
