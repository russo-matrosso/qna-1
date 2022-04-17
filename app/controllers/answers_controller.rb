class AnswersController < ApplicationController
  before_action :authenticate_user!

  def new

  end
  
  def create
    @answer = question.answers.new(answer_params)

    if @answer.save
      redirect_to @answer, notice: 'Your answer successfully created.'
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  def answer
  	@answer ||= Answer.find(params[:id])
  end

  helper_method :question, :answer

end