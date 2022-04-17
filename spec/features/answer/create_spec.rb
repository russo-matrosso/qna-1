require 'rails_helper'

feature 'User can leave an answer', %q{
  In order to help people from a community
  As an authenticated user
  I'd like to be able to leave an answer to a question
} do

  describe 'Authenticated user' do

    given(:user) { create(:user) }
    given(:question) { create(:question) }

    background do
      sign_in(user)
      visit questions_path(question)
    end

    scenario 'create an answer without errors' do

      fill_in 'Body', with: 'a good answer'
      click_on 'Leave an answer'

      expect(page).to have_content 'Your answer successfully created'
      expect(page).to have_content 'a good answer'
    end

    scenario 'asks a question with errors' do
      click_on 'Leave an answer'
      expect(page).to have_content "Body can't be blank"
    end
  end
end