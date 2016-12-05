require_relative 'acceptance_helper'

feature 'Delete answer', %q{
  In order to delete answer
  As an authenticated user
  I want to be able to have ability to delete
} do

  let(:user) { create(:user) }
  let(:user2) { create(:user, email: 'vovka@test.com') }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Authenticated user deletes answer', js: true do
    sign_in(user)
    visit questions_path
    click_on 'Show question'
    expect(page).to have_content 'lot More than 10 symbols'
    click_on 'Delete comment'
    expect(page).to_not have_content 'lot More than 10 symbols'
  end

  scenario 'Non-Author Authenticated user deletes answer', js: true do
    sign_in(user2)
    visit questions_path
    click_on 'Show question'
    expect(page).to_not have_link 'Delete comment'
  end

  scenario 'Non-Authenticated user deletes answer'  do
    visit questions_path(question)
    click_on 'Show question'
    expect(page).to_not have_content 'Delete comment'
  end
end
