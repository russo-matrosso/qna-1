require 'rails_helper'

feature 'User can add an award to question', "
  In order to reward a user who gave a best answer
  As a question's author
  I'd like to be able to add award to the question
  " do
  given(:user) { create(:user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit new_question_path
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'
    end

    scenario 'create a question with an award' do
      fill_in 'Award title', with: 'new award'
      attach_file 'Image', "#{Rails.root}/spec/images/trophy.png"
      click_on 'Ask'

      expect(page).to have_content 'new award'
    end
  end
end