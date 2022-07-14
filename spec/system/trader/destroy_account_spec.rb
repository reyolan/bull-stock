require 'rails_helper'

RSpec.describe 'Deleting of account', type: :system do
  let!(:trader) { create(:approved_confirmed_trader) }

  context 'when user is in his own account', vcr: { cassette_name: 'most_active', record: :new_episodes }  do
    it 'allows deletion of account' do
      sign_in trader

      visit edit_user_registration_path

      expect {
        accept_confirm { click_on 'Delete account' }
        sleep(0.5)
      }.to change(User, :count).by(-1)
      expect(page).to have_current_path(root_path)
      expect(page).to have_css('#alert-success')
    end
  end
end
