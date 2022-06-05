# frozen_string_literal: true

class Answer < ApplicationRecord
  has_many_attached :files
  belongs_to :question
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  validates :body, presence: true

  def mark_as_best
    question.update(best_answer_id: id)
  end
end
