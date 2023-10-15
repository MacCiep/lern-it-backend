# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::FlashcardsController, type: :request do
  describe 'PATCH /api/v1/flashcards/:id' do
    it_behaves_like 'protected endpoint', method: :get, url: '/api/v1/flashcards'

    context 'when authorized' do
      subject(:request) { patch "/api/v1/flashcards/#{id}", params:, headers: }

      let(:user) { create(:user) }
      let(:headers) { authenticated_headers({}, user) }
      let(:id) { 1 }
      let(:params) { {} }

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
        let(:new_answer) { 'New answer' }
        let(:params) { { flashcard: { answer: new_answer } } }
        let(:expected_response) { FlashcardSerializer.new(flashcard.reload).serializable_hash.to_json }

        before { request }

        it 'updates flashcard' do
          expect(flashcard.reload.answer).to eq(new_answer)
        end

        it_behaves_like 'response status', :ok

        it 'returns updated flashcard' do
          expect(response.body).to eq(expected_response)
        end
      end
    end
  end
end
