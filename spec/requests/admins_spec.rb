require 'rails_helper'
require 'spec_helper'
require_relative '../support/sign_in_admin_support'
require_relative '../support/create_trader_support'

RSpec.describe "User Management", type: :request do
  
  
  describe "Admin sign in" do
    before(:each) do
      sign_in_as_a_valid_admin
    end
    
    it "signs in admin" do
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

    it "does not render a different template" do
      get new_trader_path
      expect(response).to_not render_template(:show)
    end
  end
end
