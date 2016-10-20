class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(answer_params)

    if @question.save
      redirect_to @question
    else
      render 'new'
    end
  end

  private

  def answer_params
    params.requre(:question).permit(:title, :body)
  end
end
