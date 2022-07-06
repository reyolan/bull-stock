require 'rails_helper'
require_relative '../support/sign_in_admin_support'
require 'spec_helper'

RSpec.describe "User Management", type: :request do

  describe "Admin sign in" do
    it "should return 200:OK" do
      sign_in_as_a_valid_admin
      get traders_path
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "Admin create new user" do
    it "creates a new user trader account and redirects to traders page" do
      sign_in_as_a_valid_admin
      get new_trader_path
      expect(response).to render_template(:new)

      post traders_path, :params => { :user => {:email => "My Widget", :password => "abc123", :password_confirmation => "abc123"} }

      expect(response).to redirect_to(traders_path)
      follow_redirect!

      expect(response).to render_template(:index)
      expect(response.body).to include("Trader was successfully created.")
    end

    it "does not render a different template" do
      get new_trader_path
      expect(response).to_not render_template(:show)
    end

  end
end
