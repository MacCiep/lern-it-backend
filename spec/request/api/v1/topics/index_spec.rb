require 'rails_helper'

RSpec.describe Topic, type: :request do
  describe 'GET /api/v1/topics' do
    it_behaves_like 'protected endpoint', method: :get, url: '/api/v1/topics'

    before { create_list(:topic, 3, user:) }

    context 'when authorized' do
      let(:user) { create(:user) }
      let(:headers) { authenticated_headers({}, user) }
      let(:params) { {} }
      let(:expected_records) { Topic.all }
      let(:serialized_records) { TopicSerializer.new(expected_records).serializable_hash }

      let(:metadata) {
        {
          total_pages: (Topic.count.to_f / Pagy::DEFAULT[:items]).ceil,
          current_page: Pagy::DEFAULT[:page],
          total_count: expected_records.count,
          per_page: Pagy::DEFAULT[:items]
        }
      }

      let(:expected_response) do
        {
          records: serialized_records,
          metadata:
        }
      end

      before { get '/api/v1/topics', params: params, headers: headers }

      it_behaves_like 'properly renders index endpoint'

      context 'when pagination params are provided' do
        let(:page) { 2 }
        let(:per_page) { 1 }
        let(:params) { { page:, per_page: } }
        let(:expected_records) { [Topic.second] }

        let(:metadata) {
          {
            total_pages: Topic.count / per_page,
            current_page: page,
            total_count: Topic.count,
            per_page: per_page
          }
        }

        it_behaves_like 'properly renders index endpoint'
      end
    end
  end
end