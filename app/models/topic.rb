# frozen_string_literal: true

class Topic < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, uniqueness: true

  def default_serializer
    TopicSerializer
  end
end
