# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TopicsController, type: :request do
  describe 'POST /api/v1/topics' do
    it_behaves_like 'protected endpoint', method: :get, url: '/api/v1/topics'

    context 'when authorized' do
      subject(:request) { post '/api/v1/topics', params:, headers: }

      let(:user) { create(:user) }
      let(:headers) { authenticated_headers({}, user) }
      let(:params) { {} }
      let(:id) { 1 }

      context 'when params are invalid' do
        let(:params) { { topic: { title: nil } } }

        before { request }

        it_behaves_like 'response status', :unprocessable_entity
      end

      context 'when params are valid' do
        let(:params) { { topic: { title: 'New title' } } }
        let(:expected_response) { TopicSerializer.new(Topic.first).serializable_hash.to_json }

        before { request }

        it_behaves_like 'response status', :created

        it 'returns topic' do
          expect(response.body).to eq(expected_response)
        end
      end
    end
  end
end
