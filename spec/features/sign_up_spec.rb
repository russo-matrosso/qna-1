require 'rails_helper'

feature 'User can register and auth', '
  In order to get question from a community
  As an authenticated user
  I`d like to be able to ask the question
' do
  given(:user) { create(:user) }

  scenario 'User can register' do
    visit root_path
    click_on 'Registration'

    fill_in 'Email', with: 'new_user@mail.com'
    fill_in 'Password', with: '123qwe123'
    fill_in 'Password confirmation', with: '123qwe123'

    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(page).to have_content 'new_user@mail.com'
  end
end