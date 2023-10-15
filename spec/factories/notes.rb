# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    title { FFaker::Lorem.word }
    description { FFaker::Lorem.paragraph }
    topic
    file { blob_for('note_file.txt', 'text').signed_id }
  end
end
