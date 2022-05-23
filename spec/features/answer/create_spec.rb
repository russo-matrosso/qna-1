# frozen_string_literal: true

require 'rails_helper'

feature 'User can leave an answer', "
  In order to help people from a community
  As an authenticated user
  I'd like to be able to leave an answer to a question
" do
  describe 'Authenticated user' do
    given(:user) { create(:user) }
    given(:question) { create(:question, author: user) }

    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'create an answer without errors' do
      save_and_open_page
      fill_in 'Body', with: 'a good answer'
      click_on 'Leave an answer'

      expect(page).to have_content 'Your answer successfully created'
      expect(page).to have_content 'a good answer'
    end

    scenario 'create an answer with errors' do
      click_on 'Leave an answer'
      expect(page).to have_content "Body can't be blank"
    end

    scenario 'Unauthenticated user tries create an answer' do
      visit question_path(question)
      expect(page).to_not have_content 'Leave an answer'
    end
  end
end
