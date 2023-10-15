# frozen_string_literal: true

class Topic < ApplicationRecord
  belongs_to :user
  has_many :flashcards, dependent: :destroy
  has_many :notes, dependent: :destroy
  validates :title, presence: true, uniqueness: true

  def default_serializer
    TopicSerializer
  end
end
