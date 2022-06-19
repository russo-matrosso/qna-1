# frozen_string_literal: true

require 'rails_helper'

feature 'User can add links to question', "
  In order to provide additional info to my question
  As a question's author
  I'd like to be able to add links
" do
  given(:user) { create(:user) }
  given(:gist_url) { 'https://gist.github.com/leri-berry/b7147f15b7e6f4301f7b3c08e9678dc2' }
  given(:valid_url) { 'https://google.com' }
  given(:invalid_url) { 'invalid.com' }

  scenario 'User add valid link when asks question', js: true do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Link name', with: 'My valid link'
    fill_in 'Url', with: valid_url

    click_on 'Ask a question'

    expect(page).to have_link 'My valid link', href: valid_url
  end

  scenario 'User add gist when asks question', js: true do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Ask a question'

    expect(page).to have_link 'My gist', href: gist_url
  end

  scenario 'User tries to add invalid link when asks question', js: true do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Link name', with: 'My invalid link'
    fill_in 'Url', with: invalid_url

    click_on 'Ask a question'
    expect(page).to_not have_link 'My link', href: invalid_url
  end
end
