require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:myquestion) { create(:question, title: 'more than 10 symbols') }
  let(:answer) { create(:answer, body: 'more than 10 symbols') }
  describe 'GET #index' do
    let(:answers) { create(:answer, body: 'more than 10 symbols') }

    before { get :index, params: { question_id: myquestion } }

    it 'populates an array of all answers' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: answer, question_id: myquestion } }

    it 'assigns the requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new, params: { question_id: myquestion } }

    it 'assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: myquestion } }.to change(Answer, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { answer: attributes_for(:answer), question_id: myquestion }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'doesnt save the new answer' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer), question_id: myquestion } }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, params: { answer: attributes_for(:invalid_answer), question_id: myquestion }
        expect(response).to render_template :new
      end
    end
  end
end
