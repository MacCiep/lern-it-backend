# frozen_string_literal: true

class FlashcardSerializer
  include FastJsonapi::ObjectSerializer

  attributes :question, :answer, :difficulty, :correct, :times_vied
  attribute :correct_ratio do |object|
    if object.times_vied.zero?
      object.times_vied
    else
      object.correct / object.times_vied.to_f
    end
  end
end
