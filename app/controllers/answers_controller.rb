# frozen_string_literal: true

class AnswersController < ApplicationController
  include Voted
  include Commented

  before_action :authenticate_user!
  after_action :publish_answer, only: [:create]

  def create
    @answer = question.answers.create(answer_params.merge(author: current_user))

    respond_to do |format|
      if @answer.save
        format.json { render json: @answer }
      else
        format.json do
          render json: @answer.errors.full_messages, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    answer.update(answer_params) if current_user.author?(answer)
    @question = answer.question
  end

  def destroy
    if current_user.author?(answer)
      answer.destroy
      redirect_to question_path(answer.question), notice: 'Your answer successfully deleted.'
    else
      redirect_to question_path(answer.question)
    end
  end

  def best
    @question = answer.question
    answer.mark_as_best if current_user.author?(answer.question)
  end

  private

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: %i[name url _destroy])
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  def answer
    @answer ||= params[:id] ? Answer.find(params[:id]) : question.answers.new
  end

  def publish_answer
    return if @answer.errors.any?

    ActionCable.server.broadcast(
      'answers',
      ApplicationController.render(
        partial: 'answers/answer_channel',
        locals: { answer: @answer }
      )
    )
  end

  helper_method :question, :answer
end
