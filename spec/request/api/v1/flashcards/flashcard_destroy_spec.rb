# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Flashcard, type: :request do
  describe 'DELETE /api/v1/flashcards/:id' do
    it_behaves_like 'protected endpoint', method: :delete, url: '/api/v1/flashcards/1'

    context 'when authorized' do
      subject(:request) { delete "/api/v1/flashcards/#{id}", headers: }

      let(:user) { create(:user) }
      let(:headers) { authenticated_headers({}, user) }
      let(:id) { 1 }

      context 'when flashcard does not exist' do
        it_behaves_like 'record not found'
      end

      context 'when flashcard is not assign to user' do
        let(:flashcard) { create(:flashcard) }
        let(:id) { flashcard.id }

        it_behaves_like 'record not found'
      end

      context 'when flashcard is assign to user' do
        let(:topic) { create(:topic, user:) }
        let(:flashcard) { create(:flashcard, topic:) }
        let(:id) { flashcard.id }
        let(:params) { { flashcard: { title: 'New title' } } }

        before { request }

        it 'deletes flashcard' do
          expect(described_class.count).to eq(0)
        end

        it_behaves_like 'response status', :no_content
      end
    end
  end
end
