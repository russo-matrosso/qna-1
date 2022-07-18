require 'rails_helper'

feature 'User can delete links from the question', "
  In order to provide additional info to my question
  As a question's author
  I'd like to be able to delete links
" do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given!(:example) { create(:link, linkable: question, name: 'example', url: 'http://example.com') }

  describe 'Authenticated user', js: true do
    scenario 'delete link from his question' do
      sign_in(user)
      visit question_path(question)
      expect(page).to have_link 'example', href: 'http://example.com'
      save_and_open_page
      click_on 'Delete link'
      expect(page).to_not have_link 'example'
    end
  end

  scenario 'Unauthenticated user can not delete the link' do
    visit question_path(question)
    expect(page).to_not have_link 'Delete link'
  end
end
