class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show, :destroy ]
  before_action :set_question, only: [ :show, :edit, :destroy, :update ]

  def index
    @questions = Question.all
    @answers = Answer.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def update
    @question.update(question_params) if current_user.author_of?(@question)
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def destroy
    @question.destroy if current_user.author_of?(@question)
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
