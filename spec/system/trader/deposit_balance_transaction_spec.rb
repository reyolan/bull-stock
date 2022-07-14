require "rails_helper"

RSpec.describe "Deposit amount to increase balance", type: :system do
  let(:approved_trader) { create(:approved_confirmed_trader) }
  let(:unapproved_trader) { create(:unapproved_confirmed_trader) }
  let(:admin) { create(:admin) }

  context "when user is approved" do
    context "with valid amount" do
      it "adds amount to the balance of the trader" do
        sign_in approved_trader

        visit new_deposit_balance_transaction_path

        fill_in "deposit_transaction[amount]", with: 5000

        click_on "Confirm Deposit"

        expect { approved_trader.reload }.to change(approved_trader, :balance).by(5000)
      end
    end

    context "with invalid amount" do
      it "notifies user that the amount is invalid" do
        sign_in approved_trader

        visit new_deposit_balance_transaction_path

        fill_in "deposit_transaction[amount]", with: -1234

        click_on "Confirm Deposit"

        expect { approved_trader.reload }.not_to change(approved_trader, :balance)
        expect(page).to have_css("#error_explanation")
      end
    end
  end

  context "when user is not approved" do
    it "shows a not found page" do
      sign_in unapproved_trader

      visit new_deposit_balance_transaction_path

      expect(page).to have_text("The page you were looking for doesn't exist.")
    end
  end

  context "when user is an admin" do
    it "shows a not found page" do
      sign_in admin

      visit new_deposit_balance_transaction_path

      expect(page).to have_text("The page you were looking for doesn't exist.")
    end
  end
end
