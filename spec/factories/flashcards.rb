# frozen_string_literal: true

FactoryBot.define do
  factory :flashcard do
    question { FFaker::Lorem.sentence }
    answer { FFaker::Lorem.sentence }
    difficulty { rand(0...3) }
    correct { 0 }
    times_vied { 0 }
    topic
  end
end
