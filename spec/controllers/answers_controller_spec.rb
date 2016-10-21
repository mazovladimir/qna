require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:answer) { create(:answer, body: 'more than 10 symbols')}
  describe 'GET #index' do
    let(:answers) { create_list(:answer, 2, body: 'more than 10 symbols')}
    let(:myquestion) { create(:question, title: 'more than 10 symbols')}

    before do
      get :index, params: { question_id: myquestion }
    end

    it 'populates an array of all answers' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: answer} }

    it 'assigns the requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'renders show view' do
      expect(response).to render_template :show
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

  describe 'POST #create' do
    let(:myquestion) { create(:question, title: 'more than 10 symbols')}

    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect { post :create, answer: attributes_for(:answer) }.to change(Answer, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { answer: attributes_for(:answer) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end
  end
end
