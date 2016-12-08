require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:user2) { create(:user, email: 'vovka@test.com') }
  let(:question) { create(:question, title: 'more than 10 symbols', user: user) }
  let(:question2) { create(:question, title: 'more than 10 symbols', user: user2) }
  describe 'GET #index' do
    let(:questions) { create_list(:question, 2, title: 'more than 10 symbols', user: user) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user

    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)      
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it 'check user-question association' do
        post :create, params: { question: attributes_for(:question) }
        expect(assigns(:question).user).to eq(subject.current_user)
      end

      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'doesnt save the new question' do
        expect { post :create, params: { question: attributes_for(:invalid_question) } }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    before do 
      question.update(user: @user)
      question2
    end

    context 'author deletes question' do
      it 'deletes question' do
        expect { delete :destroy, params: { id: question }, format: :js }.to change(Question, :count).by(-1)
      end

      it 'redirect to index view' do
        delete :destroy, params: { id: question }, format: :js
        expect(response).to render_template 'questions/destroy'
      end
    end

    context 'non-author deletes question' do
      it 'deletes question' do
        expect { delete :destroy, params: { id: question2 }, format: :js }.to_not change(Question, :count)
      end

      it 'redirect to index view' do
        delete :destroy, params: { id: question2 }, format: :js
        expect(response).to render_template 'questions/destroy'
      end
    end  
  end

  describe 'PATCH #update' do
    sign_in_user
    
    context 'valid attributes' do
      it 'assings the requested question to @question' do
        patch :update, params: { id: question, question: attributes_for(:question) }, format: :js
        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes' do
        patch :update, params: { id: question }, format: :js
        question.reload
        expect(question.title).to eq 'more than 10 symbols'
        expect(question.body).to eq 'More than 10 symbols'
      end

      it 'redirects to the updated question' do
        patch :update, params: { id: question, question: attributes_for(:question) }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'invalid attributes' do
      before { patch :update, params: { id: question, question: attributes_for(:invalid_question) }, format: :js }

      it 'does not change question attributes' do
        question.reload
        expect(question.title).to eq 'more than 10 symbols'
        expect(question.body).to eq 'More than 10 symbols'
      end

      it 're-renders edit view' do
        expect(response).to render_template :update
      end
    end

    context 'author updates question' do
      it 'updates author question' do
        patch :update, params: { id: question, question: attributes_for(:question) }, format: :js
        expect(assigns(:question)).to eq question
      end
    end

    context 'non-author updates question' do
      it 'not update non-author question' do
        patch :update, params: { id: question2, question: attributes_for(:question) }, format: :js
        expect(assigns(:question)).to_not eq question
      end
    end
  end
end
