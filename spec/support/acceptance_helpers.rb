module AcceptanceMacros
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def sign_out(user)
    sign_in(user)
    visit new_question_path
    click_on 'Log Out'
  end

  def create_question
    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Text tex'
    click_on 'Create'
  end
end
