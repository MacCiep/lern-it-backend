require 'rails_helper'

RSpec.describe Topic, type: :request do
  describe 'PATCH /api/v1/topics/:id' do
    it_behaves_like 'protected endpoint', method: :get, url: '/api/v1/topics'

    context 'when authorized' do
      let(:user) { create(:user) }
      let(:headers) { authenticated_headers({}, user) }
      let(:id) { 1 }
      let(:params) { { } }

      subject(:request) { patch "/api/v1/topics/#{id}", params:, headers: headers }

      context 'when topic does not exist' do
        it_behaves_like 'record not found'
      end

      context 'when topic is not assign to user' do
        let(:topic) { create(:topic) }
        let(:id) { topic.id }

        it_behaves_like 'record not found'
      end

      context 'when topic is assign to user' do
        let(:topic) { create(:topic, user:) }
        let(:id) { topic.id }
        let(:params) { { topic: { title: 'New title' } } }
        let(:expected_response) { TopicSerializer.new(topic.reload).serializable_hash.to_json }

        before { request }

        it 'updates topic' do
          expect(topic.reload.title).to eq('New title')
        end

        it_behaves_like 'response status', :ok

        it 'returns updated topic' do
          expect(response.body).to eq(expected_response)
        end
      end
    end
  end
end