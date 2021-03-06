require 'rails_helper'

describe 'logged in user seeks new api key' do
  it 'visits form' do
    user = create(:requester_user)
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit '/api/accounts/new'

    expect(page).to have_content('First Name')
    expect(page).to have_content('Last Name')
    expect(page).to have_content('Email Address')
  end

  context 'correct password is entered' do
    it 'fills in password and description of use and gets an api key' do
      user = create(:requester_user)
      ApplicationController.any_instance.stubs(:current_user).returns(user)
      visit '/api/accounts/new'

      fill_in 'url', with: 'test.com'
      fill_in 'redirect_url', with: 'test.com'
      fill_in 'password', with: user.password
      fill_in 'description', with: 'This is a test'
      fill_in 'app_name', with: 'Test App'
      click_on 'Send Request'

      expect(page).to have_content(UserApi.first.key)
      expect(current_path).to eq('/api/accounts/dashboard')
      expect(UserApi.first.user).to eq(user)
      expect(UserApi.first.description).to eq('This is a test')
    end
  end

  context 'incorrect password is entered' do
    it 'fills in incorrect password and rejected api key' do
      user = create(:requester_user)
      ApplicationController.any_instance.stubs(:current_user).returns(user)
      visit '/api/accounts/new'

      fill_in 'url', with: 'test.com'
      fill_in 'redirect_url', with: 'test.com'
      fill_in 'password', with: 'wrong'
      fill_in 'description', with: 'This is a test'
      fill_in 'app_name', with: 'Test App'
      click_on 'Send Request'

      expect(page).to have_content('incorrect password')
      expect(UserApi.count).to eq(0)
      expect(current_path).to eq('/api/accounts/new')
    end
  end
end
