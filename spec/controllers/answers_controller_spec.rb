require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'GET #index' do
    let(:answers) { create_list(:answer, 2, body: 'more than 10 symbols')}
    let(:myquestion) { create(:question, title: 'more than 10 symbols')}

    before do
      get :index, params: { question_id: myquestion }
    end

    it 'populates an array of all answers' do
      expect(assigns(:answers)).to_not match_array(answers)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    let(:myquestion) { create(:question, title: 'more than 10 symbols')}

    before do 
      get :new, params: { question_id: myquestion }
    end

    it 'assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end
end
