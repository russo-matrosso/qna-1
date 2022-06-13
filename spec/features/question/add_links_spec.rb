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
  given(:invalid_url) { 'google.com' }

  scenario 'User adds link when asks question', js: true do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url


    click_on 'Ask'


    expect(page).to have_link 'My gist', href: gist_url
  end

  scenario 'User tries to add invalid link when asks question', js: true do
    sign_in(user)
    visit new_question_path

    within('.nested-fields') do
      fill_in 'Link name', with: 'Invalid link'
      fill_in 'Url', with: invalid_url
    end

    click_on 'Ask a question'

    expect(page).to have_content 'is not a valid URL'
  end

  scenario 'User can add several links when asks a question', js: true do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Link name', with: 'Good link'
    fill_in 'Url', with: valid_url

    click_on 'add link'

    within('.nested-fields') do
      fill_in 'Link name', with: 'Valid link'
      fill_in 'Url', with: valid_url
    end
    

    click_on 'Ask a question'

    save_and_open_page


    expect(page).to have_link 'Good link', href: valid_url
    expect(page).to have_link 'Valid link', href: valid_url
  end
end
