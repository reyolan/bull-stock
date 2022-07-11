require 'rails_helper'

RSpec.describe 'Trader registration', type: :system do
  context 'with valid details' do
    it 'is successful with email confirmation' do
      visit(new_user_registration_path)

      fill_in 'user_email', with: 'example@example.com'
      fill_in 'user_password', with: '123456'
      fill_in 'user_password_confirmation', with: '123456'

      expect { within('form') { click_on('Sign up') } }.to change(User, :count).by(1)
                                                       .and change(ActionMailer::Base.deliveries, :count).by(1)
    end
  end

  context 'with invalid details' do
    it 'notifies the user that their details is invalid' do
      visit(new_user_registration_path)

      fill_in 'user_email', with: 'example@example.com'
      fill_in 'user_password', with: '12345'
      fill_in 'user_password_confirmation', with: '12345'

      expect { within('form') { click_on('Sign up') } }.not_to(change { User.count })
      expect(page).to have_css('#error_explanation')
    end
  end
end
