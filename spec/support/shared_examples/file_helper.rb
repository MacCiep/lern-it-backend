# frozen_string_literal: true

module FileHelpers
  def blob_for(name, type = 'image/png')
    ActiveStorage::Blob.create_and_upload!(
      io: File.open(file_fixture(name)),
      filename: name,
      content_type: type
    )
  end
end

RSpec.configure do |config|
  config.include(FileHelpers)
end
