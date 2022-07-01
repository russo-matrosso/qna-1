# frozen_string_literal: true

class AnswersChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'answers'
  end

  def unsubscribed; end
end
