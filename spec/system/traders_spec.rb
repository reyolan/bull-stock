require 'rails_helper'

RSpec.describe "Trader Feature", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'allows creation of trader account to buy and sell stocks' do
    visit(new_user_registration_path)

    fill_in 'user_email', with: 'example@example.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'

    within('form') do
      click_on('Sign up')
    end

    expect(User.all.count).to(eq(1))
  end
end
