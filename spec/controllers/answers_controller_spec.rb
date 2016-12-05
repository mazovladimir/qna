require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create :user }
  let(:user2) { create :user, email: 'vovka@test.com' }
  let(:myquestion) { create(:question, title: 'more than 10 symbols', user: user) }
  let!(:answer) { create(:answer, body: 'more than 10 symbols', user: user, question: myquestion  ) }
  let(:answer2) { create(:answer, body: 'more than 10 symbols', user: user2  ) }
  describe 'GET #new' do
    sign_in_user

    before { get :new, params: { question_id: myquestion } }

    it 'assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      it 'saves the new answer in the database' do
         expect { post :create, params: { answer: attributes_for(:answer), question_id: myquestion, format: :js } }.to change(Answer, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { answer: attributes_for(:answer), question_id: myquestion, format: :js }
        expect(response).to render_template :create
      end
      
      it 'check user-answer association' do
        post :create, params: { answer: attributes_for(:answer), question_id: myquestion, format: :js }
        expect(assigns(:answer).user).to eq(subject.current_user)
      end
    end

    context 'with invalid attributes' do
      it 'doesnt save the new answer' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer), question_id: myquestion, format: :js } }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, params: { answer: attributes_for(:invalid_answer), question_id: myquestion, format: :js }
        expect(response).to render_template :create
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    before do
      answer.update(user: @user)
      answer2
      myquestion.answers << answer2
    end

    context 'author deletes answer' do
      it 'deletes question' do
        expect { delete :destroy, params: { id: answer, question_id: myquestion, format: :js } }.to change(Answer, :count).by(-1)
      end

      it 'redirect to show view question' do
        delete :destroy, params: { id: answer, question_id: myquestion, format: :js }
        expect(response).to render_template 'answers/destroy'
      end
    end

    context 'non-author deletes answer' do
      it 'deletes question' do
        expect { delete :destroy, params: { id: answer2, question_id: myquestion, format: :js } }.to_not change(Answer, :count)
      end

      it 'redirect to show view question' do
        delete :destroy, params: { id: answer2, question_id: myquestion, format: :js }
        expect(response).to render_template 'answers/destroy'
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user

    it 'assings the requested answer to @answer' do
      patch :update, params: { id: answer, question_id: myquestion, answer: attributes_for(:answer), format: :js }
      expect(assigns(:answer)).to eq answer
    end

    it 'assigns the question' do
      patch :update, params: { id: answer, question_id: myquestion, answer: attributes_for(:answer), format: :js }
      expect(assigns(:question)).to eq myquestion
    end

    it 'changes answer attributes' do
      patch :update, params: { id: answer, question_id: myquestion, format: :js }
      answer.reload
      expect(answer.body).to eq 'more than 10 symbols'
    end

    it 'render update template' do
      patch :update, params: { id: answer, question_id: myquestion, answer: attributes_for(:answer), format: :js }
      expect(response).to render_template :update
    end

    it 'sets answer as best' do
      patch :set_best, params: { id: answer, question_id: myquestion, answer: attributes_for(:answer), format: :js }
    end
  end
end
