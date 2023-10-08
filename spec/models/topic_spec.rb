# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Topic do
  subject(:topic) { build(:topic) }

  describe 'validations' do
    it 'validates the presence of title' do
      expect(topic).to validate_presence_of(:title)
    end

    it 'validates the uniqueness of title' do
      expect(topic).to validate_uniqueness_of(:title)
    end
  end
end
