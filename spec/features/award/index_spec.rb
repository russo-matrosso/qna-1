require 'rails_helper'

feature 'User can watch a list of awards', "
  In order to watch all my awards for the best answers
  As an user
  I'd like to be able to watch a list of my awards
" do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, question: question, author: user) }
  given!(:award) { create(:award, question: question) }

  scenario 'User view his awards', js: true do
    sign_in(user)

    visit question_path(question)
    click_on('Choose')
    visit awards_path

    expect(page).to have_content 'Question'
    expect(page).to have_content question.title
    expect(page).to have_content 'Award'
    expect(page).to have_content award.name
    expect(page).to have_content 'Image'
  end
end