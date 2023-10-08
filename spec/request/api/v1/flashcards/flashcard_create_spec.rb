# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Flashcard, type: :request do
  describe 'POST /api/v1/flashcards' do
    it_behaves_like 'protected endpoint', method: :get, url: '/api/v1/flashcards'

    context 'when authorized' do
      subject(:request) { post '/api/v1/flashcards', params:, headers: }

      let(:user) { create(:user) }
      let(:headers) { authenticated_headers({}, user) }
      let(:params) { {} }
      let(:id) { 1 }

      context 'when params are invalid' do
        let(:params) { { flashcard: { title: nil } } }

        it_behaves_like 'record not found'
      end

      context 'when params are valid' do
        let(:params) do
          { flashcard: { title: 'New title', question: 'Question', answer: 'Answer', topic_id: topic.id } }
        end
        let(:expected_response) { FlashcardSerializer.new(described_class.first).serializable_hash.to_json }

        context 'when topic does not belongs to user' do
          let(:topic) { create(:topic) }

          it_behaves_like 'record not found'
        end

        context 'when topic belongs to user' do
          let(:topic) { create(:topic, user:) }

          before { request }

          it_behaves_like 'response status', :created

          it 'returns flashcard' do
            expect(response.body).to eq(expected_response)
          end
        end
      end
    end
  end
end
