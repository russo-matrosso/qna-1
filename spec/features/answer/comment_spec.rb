# frozen_string_literal: true

require 'rails_helper'

feature 'User can add comments to answer', "
	In order to leave additional information to answer
	As an authenticated
	I'd like to be able to add comments
" do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, question: question, author: user) }

  scenario 'leave a comment to answer', js: true do
    sign_in(user)
    visit question_path(question)
    within '.new-answer-comment' do
      fill_in 'Your comment', with: 'New comment'
      click_on 'Add comment'
    end

    expect(page).to have_content('New comment')
  end
end
