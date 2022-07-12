require 'rails_helper'

RSpec.describe 'Admin login', type: :system do
  let(:admin) { create(:admin) }

  context 'with valid credentials' do
    it 'allows admin to sign in' do
      visit(new_user_session_path)
      fill_in 'user_email', with: admin.email
      fill_in 'user_password', with: admin.password
      within('form') { click_on('Log in') }

      expect(page).to have_current_path(traders_path)
    end
  end
end
