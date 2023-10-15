# frozen_string_literal: true

class NoteSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :priority
end
