# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::NotesController, type: :request do
  describe 'POST /api/v1/notes' do
    it_behaves_like 'protected endpoint', method: :get, url: '/api/v1/notes'

    context 'when authorized' do
      subject(:request) { post '/api/v1/notes', params:, headers: }

      let(:user) { create(:user) }
      let(:headers) { authenticated_headers({}, user) }
      let(:params) { {} }

      context 'when params are invalid' do
        let(:params) { { title: nil } }

        before { request }

        it_behaves_like 'response status', :unprocessable_entity
      end

      context 'when params are valid' do
        let(:topic_id) { create(:topic, user:).id }
        let(:params) { { title: 'New title', priority: :low, topic_id:, file: fixture_file_upload('note_file.txt') } }
        let(:expected_response) { NoteSerializer.new(Note.first).serializable_hash.to_json }

        before { request }

        it_behaves_like 'response status', :created

        it 'returns note' do
          expect(response.body).to eq(expected_response)
        end

        it 'assigns file to note' do
          expect(Note.first.file).to be_attached
        end
      end
    end
  end
end
