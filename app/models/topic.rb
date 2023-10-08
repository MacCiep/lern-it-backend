class Topic < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, uniqueness: true
  validates :user, presence: true

  def default_serializer
    TopicSerializer
  end
end