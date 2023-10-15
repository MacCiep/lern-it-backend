require 'rails_helper'

RSpec.describe Api::V1::NotesController, type: :request do
  describe 'PATCH /api/v1/notes' do
    it_behaves_like 'protected endpoint', method: :patch, url: '/api/v1/notes/1'

    context 'when authorized' do
subject(:request) { patch "/api/v1/notes/#{id}", params: params, headers: headers }

      let(:user) { create(:user) }
      let(:headers) { authenticated_headers({}, user) }
      let(:id) { 1 }
      let(:params) { {} }

      context 'when note does not exist' do
        it_behaves_like 'record not found'
      end

      context 'when note is not assign to user' do
        let(:note) { create(:note) }
        let(:id) { note.id }

        it_behaves_like 'record not found'
      end

      context 'when note is assign to user' do
        let(:topic) { create(:topic, user: user) }
        let(:note) { create(:note, topic: topic) }
        let(:id) { note.id }
        let(:params) { { title: 'New title' } }
        let(:expected_response) { NoteSerializer.new(note.reload).serializable_hash.to_json }

        before { request }

        it 'updates note' do
          expect(note.reload.title).to eq('New title')
        end

        it_behaves_like 'response status', :ok

        it 'returns updated note' do
          expect(response.body).to eq(expected_response)
        end
      end
    end
  end
end