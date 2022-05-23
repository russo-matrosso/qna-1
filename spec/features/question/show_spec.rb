# frozen_string_literal: true

require 'rails_helper'

feature 'User can view a question and answers to it', "
  In order to find a appropriate solution to a question
  As an user
  I'd like to be able to view a question and answers to it
" do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given!(:answers) { create_list(:answer, 3, question: question, author: user) }

  scenario 'can see a question and answers to it' do
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body

    answers.each { |answer| expect(page).to have_content(answer.body) }
  end
end
