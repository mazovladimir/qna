class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :destroy ]
  before_action :set_question, only: [ :new, :create, :destroy ]
  
  def new
    @answer = Answer.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy
    @answer = Answer.find(params[:id])

    @answer.destroy if current_user.author_of?(@answer)
  end

  private
  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
