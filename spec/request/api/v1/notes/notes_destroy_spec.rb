# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::NotesController, type: :request do
  describe 'DELETE /api/v1/notes' do
    it_behaves_like 'protected endpoint', method: :delete, url: '/api/v1/notes/1'

    context 'when authorized' do
      subject(:request) { delete "/api/v1/notes/#{id}", headers: }

      let(:user) { create(:user) }
      let(:headers) { authenticated_headers({}, user) }
      let(:id) { 1 }

      context 'when note does not exist' do
        it_behaves_like 'record not found'
      end

      context 'when note is not assign to user' do
        let(:note) { create(:note) }
        let(:id) { note.id }

        it_behaves_like 'record not found'
      end

      context 'when note is assign to user' do
        let(:topic) { create(:topic, user:) }
        let(:note) { create(:note, topic:) }
        let(:id) { note.id }
        let(:params) { { note: { title: 'New title' } } }

        before { request }

        it 'deletes note' do
          expect(Note.count).to eq(0)
        end

        it_behaves_like 'response status', :no_content
      end
    end
  end
end
