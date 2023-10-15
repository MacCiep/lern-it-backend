# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::NotesController, type: :request do
  describe 'GET /api/v1/notes' do
    it_behaves_like 'protected endpoint', method: :get, url: '/api/v1/notes'

    context 'when authorized' do
      subject(:request) { get '/api/v1/notes', headers: }

      let(:user) { create(:user) }
      let(:headers) { authenticated_headers({}, user) }

      context 'when user has no notes' do
        before { request }

        it_behaves_like 'response status', :ok

        it_behaves_like 'returns empty data'
      end

      context 'when user has notes' do
        let(:expected_response) do
          {
            records: expected_records,
            metadata: {
              total_pages: 1,
              current_page: 1,
              total_count: user.notes.count,
              per_page: 20
            }
          }
        end

        let(:topic) { create(:topic, user:) }
        let!(:note) { create(:note, topic:) }
        let(:expected_records) { NoteSerializer.new([note]).serializable_hash }

        before { request }

        it_behaves_like 'response status', :ok

        it 'returns notes' do
          expect(response.body).to eq(expected_response.to_json)
        end
      end
    end
  end
end
