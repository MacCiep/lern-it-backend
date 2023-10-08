# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Topic do
  subject(:topic) { build(:topic) }

  describe 'validations' do
    it 'validates the presence of title' do
      is_expected.to validate_presence_of(:title)
    end

    it 'validates the uniqueness of title' do
      is_expected.to validate_uniqueness_of(:title)
    end

    it 'validates the presence of user' do
      is_expected.to validate_presence_of(:user)
    end
  end
end