require 'rails_helper'

RSpec.describe Topic, type: :request do
  describe 'DELETE /api/v1/topics/:id' do
    it_behaves_like 'protected endpoint', method: :delete, url: '/api/v1/topics/1'

    context 'when authorized' do
      let(:user) { create(:user) }
      let(:headers) { authenticated_headers({}, user) }
      let(:id) { 1 }

      subject(:request) { delete "/api/v1/topics/#{id}", headers: headers }

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

        before { request }

        it 'deletes topic' do
          expect(Topic.count).to eq(0)
        end

        it_behaves_like 'response status', :no_content
      end
    end
  end
end