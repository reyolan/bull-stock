require 'rails_helper'
require 'spec_helper'
require_relative '../support/sign_in_admin_support'
require_relative '../support/admin_create_trader_support'

RSpec.describe "User Management", type: :request do
  describe "Admin manages traders accounts" do
    before(:each) do
      sign_in_as_a_valid_admin
    end

    it "signs in admin" do
      get traders_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end


    describe 'Creation of trader account'
      context 'when user is an admin' do 
        it "creates a new user trader account and redirects to traders page" do
          get new_trader_path
          expect(response).to have_http_status(200)
          expect(response).to render_template(:new)
          create_trader_by_admin
          expect(response).to redirect_to(traders_path)
          follow_redirect!
          expect(response.body).to include("Trader was successfully created.")
        end
      end
    end

    it "does not render a different template" do
      get new_trader_path
      expect(response).to have_http_status(200)
      expect(response).to_not render_template(:show)
    end

    it "edits a user trader account and redirects to traders page" do
      create_trader_by_admin
      get edit_trader_path(User.last)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
      put trader_path, :params => { :user => {:email => Faker::Internet.email }}
      follow_redirect!
      expect(response).to render_template(:index)
      expect(response.body).to include('Trader details was successfully updated.')
    end

    it "views specific trader account" do
      create_trader_by_admin
      get trader_path(User.last)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
      expect(response.body).to include("#{User.last.email}")
    end

    it "views all traders that registered in the app" do
      create(:approved_confirmed_trader)
      get traders_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to include("Traders")
      expect(response.body).to include("Email")
      expect(response.body).to include("Email Confirmation")
      expect(response.body).to include("Account Approval")
      expect(response.body).to include("Registration Date")
      expect(response.body).to include("Action")
    end

    it "views all traders that has pending email confirmation" do
      create(:unapproved_confirmed_trader)
      get pending_traders_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to include("Pending Traders")
      expect(response.body).to include("Email")
      expect(response.body).to include("Email Confirmation")
      expect(response.body).to include("Registration Date")
      expect(response.body).to include("Action")
    end

    it "approves a trader" do
      create(:unapproved_confirmed_trader)
      get pending_traders_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      put approved_trader_path(User.last), :params => { :user => {:approved => true} }
      follow_redirect!
      expect(response).to render_template(:index)
      expect(response.body).to include("#{User.last.email} has been successfully approved.")
    end

    it "views all stock transactions made by traders" do
      create(:buy_transaction)
      get stock_transactions_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to include("Stock Transactions")
      expect(response.body).to include("Time")
      expect(response.body).to include("Stock Transaction ID")
      expect(response.body).to include("Trader")
      expect(response.body).to include("Symbol")
      expect(response.body).to include("Company Name")
      expect(response.body).to include("Unit Price")
      expect(response.body).to include("Quantity")
      expect(response.body).to include("Amount")
      expect(response.body).to include("Type")
    end

    it "views all balance transactions made by traders" do
      create(:deposit_transaction)
      get balance_transactions_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to include("Balance Transactions")
      expect(response.body).to include("Time")
      expect(response.body).to include("Balance Transaction ID")
      expect(response.body).to include("Trader")
      expect(response.body).to include("Amount")
      expect(response.body).to include("Type")
    end
  end
end