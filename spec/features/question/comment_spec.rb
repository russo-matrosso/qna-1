require 'rails_helper'

feature 'User can add comments to question', "
	In order to leave additional information about question
	As an authenticated
	I'd like to be able to add comments
" do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }

  scenario 'User add comment to question', js: true do
    sign_in(user)
    visit question_path(question)
    within '.new-question-comment' do
      fill_in 'Your comment', with: 'New comment'
      click_on 'Add comment'
    end
    expect(page).to have_content('New comment')
  end
end
