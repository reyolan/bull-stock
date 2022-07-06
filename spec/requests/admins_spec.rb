require 'rails_helper'
require 'spec_helper'
require_relative '../support/sign_in_admin_support'
require_relative '../support/create_trader_support'

RSpec.describe "User Management", type: :request do
  
  
  describe "Admin" do
    before(:each) do
      sign_in_as_a_valid_admin
    end
    
    it "signs in" do
      get traders_path
      expect(response).to render_template(:index)
    end

    it "creates a new user trader account and redirects to traders page" do
      get new_trader_path
      expect(response).to render_template(:new)
      create_trader_by_admin
      expect(response).to redirect_to(traders_path)
      follow_redirect!
      expect(response.body).to include("Trader was successfully created.")
    end
    
    it "edits a user trader account and redirects to traders page" do
      get new_trader_path
      create_trader_by_admin
      get edit_trader_path(User.last)
      expect(response).to render_template(:edit)
      put trader_path, :params => { :user => {:email => Faker::Internet.email }}
      follow_redirect!
      expect(response.body).to include('Trader details was successfully updated.')
    end
    
    it "views specific trader account" do
      create_trader_by_admin
      get trader_path(User.last)
      expect(response).to render_template(:show)
      expect(response.body).to include("#{User.last.email}")
    end
    
    it "views all traders that registered in the app" do
      get traders_path
      expect(response).to render_template(:index)
      expect(response.body).to include("Email")
      expect(response.body).to include("Email Confirmation")
      expect(response.body).to include("Account Approval")
      expect(response.body).to include("Registration Date")
      expect(response.body).to include("Action")
    end


    
    
  end
end
