# frozen_string_literal: true

class Flashcard < ApplicationRecord
  belongs_to :topic

  validates :question, presence: true
  validates :answer, presence: true

  enum difficulty: {
    easy: 0,
    medium: 1,
    hard: 2
  }
end
