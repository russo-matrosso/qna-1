require 'rails_helper'

feature 'User can leave an answer', "
  In order to help people from a community
  As an authenticated user
  I'd like to be able to leave an answer to a question
" do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }

  context 'muliple sessions' do
    scenario 'answer appears on other users page', js: true do
      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
      end

      Capybara.using_session('guest') do
        visit question_path(question)
      end

      Capybara.using_session('user') do
        fill_in 'Body', with: 'a good answer'
        click_on 'Leave an answer'
        # save_and_open_page
        expect(page).to have_content 'a good answer'
      end

      Capybara.using_session('guest') do
        expect(page).to have_content 'a good answer'
      end
    end
  end

  describe 'Authenticated user', js: true do
    given(:user) { create(:user) }
    given(:question) { create(:question, author: user) }

    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'create an answer without errors' do
      # save_and_open_page
      fill_in 'Body', with: 'a good answer'
      click_on 'Leave an answer'

      expect(current_path).to eq question_path(question)
      within '.answers' do # чтобы убедиться, что ответ в списке, а не в форме
        expect(page).to have_content 'a good answer'
      end
    end

    scenario 'create an answer with errors' do
      click_on 'Leave an answer'
      expect(page).to have_content "Body can't be blank"
    end

    scenario 'create an answer with attached files' do
      fill_in 'Body', with: 'a good answer'

      attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Leave an answer'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end

    scenario 'Unauthenticated user tries create an answer' do
      visit question_path(question)
      expect(page).to_not have_content 'Leave an answer'
    end

    scenario 'Authenticated user creates answer with errors' do
      click_on 'Leave an answer'
      expect(page).to have_content "Body can't be blank"
    end
  end
end
