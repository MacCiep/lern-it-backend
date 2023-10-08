# frozen_string_literal: true

FactoryBot.define do
  factory :topic do
    title { FFaker::Lorem.word }
    user
  end
end
