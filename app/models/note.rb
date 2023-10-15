# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :topic

  has_one_attached :file

  validates :title, presence: true

  enum priority: {
    low: 0,
    medium: 1,
    high: 2
  }
end
