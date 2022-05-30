# frozen_string_literal: true

require 'rails_helper'

feature 'User can edit his question', "
  In order to correct mistakes
  As an author of question
  I'd like to be able to edit my question
" do
  given!(:user) { create(:user) }
  given!(:user_author) { create(:user) }
  given!(:question) { create(:question, author: user_author) }

  scenario 'Unauthenticated can not edit question' do
    visit question_path(question)
    expect(page).to_not have_link 'Edit the question'
  end

  describe 'Author' do
    background do
      sign_in(user_author)
      visit question_path(question)
      click_on 'Edit the question'
    end

    scenario 'edits his question without mistakes', js: true do
      within "#question-#{question.id}" do
        fill_in 'Title', with: 'edited title'
        fill_in 'Your question', with: 'edited question'
        click_on 'Save'

        expect(page).to_not have_content question.body
        expect(page).to have_content 'edited title'
        expect(page).to have_content 'edited question'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'edit his question with mistakes', js: true do
      within "#question-#{question.id}" do
        fill_in 'Your question', with: nil
        click_on 'Save'

        expect(page).to have_content "Body can't be blank"
      end
    end
  end

  describe 'Not author' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario "tries to edit other user's question", js: true do
      expect(page).to_not have_content 'Edit the question'
    end
  end
end
