require 'rails_helper'

feature 'Delete answer', %q{
  In order to delete answer
  As an authenticated user
  I want to be able to have ability to delete
} do

  given(:user) { create(:user) }
  let (:question) { create(:question, user: user) }
  let (:answer) { create(:answer, question: question, user: user) }

  scenario 'Authenticated user list question' do
    sign_in(user)

    question
    answer

    visit questions_path

    click_on 'Show question'

    click_on 'Delete comment'

    expect(page).to_not have_content 'lot More than 10 symbols'
  end
end
