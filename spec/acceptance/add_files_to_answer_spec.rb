require_relative 'acceptance_helper'

feature 'Add files to answer', %q{
  In order to illustrate my answer
  As an answer's author
  I'd like to be able to attach files
} do

  let(:user) { create(:user) }
  let(:question) { create(:question) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User adds file when answer question', js: true do
    fill_in 'Your answer', with: 'My new answer'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end
end
