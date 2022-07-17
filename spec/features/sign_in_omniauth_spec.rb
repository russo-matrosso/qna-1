require 'rails_helper'

feature 'Authorization from providers', %q{
  In order to have access to app
  As a user
  I want to be able to sign in with my social network accounts
} do

  given!(:user) { create(:user, email: 'new@user.com')}
  background { visit new_user_session_path }

  describe 'Sign in with GitHub' do
    scenario 'sign in user' do
      mock_auth_hash(:github, 'new@user.com')
      click_on 'Sign in with GitHub'
      #save_and_open_page

      expect(page).to have_content 'Successfully authenticated from Github account.'
    end

    scenario "oauth provider doesn't have user's email" do
      mock_auth_hash(:github)
      click_on 'Sign in with GitHub'

      expect(page).to have_content 'Enter your email'
      fill_in 'email', with: 'new@mail.ru'
      click_on 'Submit'

      open_email('new@mail.ru')
      current_email.click_link 'Confirm my account'
      expect(page).to have_content 'Your email address has been successfully confirmed.'
    end
  end

  describe 'Sign in with Vkontakte' do
  	scenario 'sign in user' do
  		mock_auth_hash(:vkontakte, 'new@user.com')
  		click_on 'Sign in with Vkontakte'

  		expect(page).to have_content 'Successfully authenticated from Vkontakte account.'
  	end

  	scenario "oauth provider doesn't have user's email" do
  		mock_auth_hash(:vkontakte)
      click_on 'Sign in with Vkontakte'

      expect(page).to have_content 'Enter your email'
      fill_in 'email', with: 'new@mail.ru'
      click_on 'Submit'

      open_email('new@mail.ru')
      current_email.click_link 'Confirm my account'
      expect(page).to have_content 'Your email address has been successfully confirmed.'
  	end
  end
end