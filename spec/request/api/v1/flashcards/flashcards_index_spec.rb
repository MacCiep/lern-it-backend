# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::FlashcardsController, type: :request do
  describe 'GET /api/v1/flashcards' do
    before do
      topic = create(:topic, user:)
      create_list(:flashcard, 3, topic:)
    end

    it_behaves_like 'protected endpoint', method: :get, url: '/api/v1/flashcards'

    context 'when authorized' do
      let(:user) { create(:user) }
      let(:headers) { authenticated_headers({}, user) }
      let(:params) { {} }
      let(:expected_records) { Flashcard.all }
      let(:serialized_records) { FlashcardSerializer.new(expected_records).serializable_hash }

      let(:metadata) do
        {
          total_pages: (Flashcard.count.to_f / Pagy::DEFAULT[:items]).ceil,
          current_page: Pagy::DEFAULT[:page],
          total_count: expected_records.count,
          per_page: Pagy::DEFAULT[:items]
        }
      end

      let(:expected_response) do
        {
          records: serialized_records,
          metadata:
        }
      end

      before { get '/api/v1/flashcards', params:, headers: }

      it_behaves_like 'properly renders index endpoint'

      context 'when pagination params are provided' do
        let(:page) { 2 }
        let(:per_page) { 1 }
        let(:params) { { page:, per_page: } }
        let(:expected_records) { [Flashcard.second] }

        let(:metadata) do
          {
            total_pages: Flashcard.count / per_page,
            current_page: page,
            total_count: Flashcard.count,
            per_page:
          }
        end

        it_behaves_like 'properly renders index endpoint'
      end
    end
  end
end
