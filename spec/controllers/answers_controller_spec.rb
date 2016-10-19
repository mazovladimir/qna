require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'GET #index' do
    it 'populates an array of all answers' do
      answer1 = FactoryGirl.create(:answer)
      answer2 = FactoryGirl.create(:answer)

      get :index

      expect(assigns(:answers)).to match_array([answer1, answer2])
    end

    it 'renders index view' do
      get :index
      expect(response).to render_template :index
    end
  end
end
