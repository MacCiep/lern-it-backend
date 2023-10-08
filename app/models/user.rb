# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :trackable,
         :recoverable, :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  has_many :topics, dependent: :destroy
  has_many :flashcards, through: :topics
end
