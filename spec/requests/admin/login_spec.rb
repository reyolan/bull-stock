require 'rails_helper'
require 'spec_helper'

RSpec.describe "Admin login", type: :request do
  let(:admin) { create(:admin) }

  context "with valid credentials" do
    it "signs in admin" do
        sign_in admin
        get traders_path
        expect(response).to render_template(:index)
        expect(response.body).to include("#{admin.email}")
    end
  end
end