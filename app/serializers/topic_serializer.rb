# frozen_string_literal: true

class TopicSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title
end
