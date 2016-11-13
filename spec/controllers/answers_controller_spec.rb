require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create :user }
  let(:user2) { create :user, email: 'vovka@test.com' }
  let(:myquestion) { create(:question, title: 'more than 10 symbols', user: user) }
  let(:answer) { create(:answer, body: 'more than 10 symbols', user: user  ) }
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
         expect { post :create, params: { answer: attributes_for(:answer), question_id: myquestion } }.to change(myquestion.answers, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { answer: attributes_for(:answer), question_id: myquestion }
        expect(response).to redirect_to question_path(assigns(:question))
      end
      
      it 'check user-answer association' do
        post :create, params: { answer: attributes_for(:answer), question_id: myquestion }
        expect(assigns(:answer).user).to eq(subject.current_user)
      end
    end

    context 'with invalid attributes' do
      it 'doesnt save the new answer' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer), question_id: myquestion } }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, params: { answer: attributes_for(:invalid_answer), question_id: myquestion }
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    context 'author deletes answer' do
      before { answer }
      before { myquestion.answers << answer }
      it 'deletes question' do
        expect { delete :destroy, params: { id: answer, question_id: myquestion } }.to change(myquestion.answers, :count).by(-1)
      end

      it 'redirect to show view question' do
        delete :destroy, params: { id: answer, question_id: myquestion }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'non-author deletes answer' do
      before { answer2 }
      before { myquestion.answers << answer2 }
      it 'deletes question' do
        expect { delete :destroy, params: { id: answer2, question_id: myquestion } }.to_not change(Answer, :count)
      end

      it 'redirect to show view question' do
        delete :destroy, params: { id: answer2, question_id: myquestion }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end
  end
end
