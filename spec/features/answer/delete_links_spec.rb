require 'rails_helper'

feature 'User can delete links from the answer', "
  In order to provide additional info to my answer
  As an answer's author
  I'd like to be able to delete links
" do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given(:answer) { create(:answer, question: question, author: user) }
  given!(:example) { create(:link, linkable: answer, name: 'example', url: 'http://exe.com') }

  describe 'Authenticated user', js: true do
    scenario 'delete link from his answer' do
      sign_in(user)
      visit question_path(question)
      within '.answers' do
        expect(page).to have_link 'example', href: 'http://exe.com'
        click_on 'Delete link'
        expect(page).to_not have_link 'example'
      end
    end
  end

  scenario 'Unauthenticated user can not delete the link' do
    visit question_path(question)
    expect(page).to_not have_link 'Delete the link'
  end
end
