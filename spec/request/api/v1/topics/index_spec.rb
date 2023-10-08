# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Topic, type: :request do
  describe 'GET /api/v1/topics' do
    before { create_list(:topic, 3, user:) }

    it_behaves_like 'protected endpoint', method: :get, url: '/api/v1/topics'

    context 'when authorized' do
      let(:user) { create(:user) }
      let(:headers) { authenticated_headers({}, user) }
      let(:params) { {} }
      let(:expected_records) { described_class.all }
      let(:serialized_records) { TopicSerializer.new(expected_records).serializable_hash }

      let(:metadata) do
        {
          total_pages: (described_class.count.to_f / Pagy::DEFAULT[:items]).ceil,
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

      before { get '/api/v1/topics', params:, headers: }

      it_behaves_like 'properly renders index endpoint'

      context 'when pagination params are provided' do
        let(:page) { 2 }
        let(:per_page) { 1 }
        let(:params) { { page:, per_page: } }
        let(:expected_records) { [described_class.second] }

        let(:metadata) do
          {
            total_pages: described_class.count / per_page,
            current_page: page,
            total_count: described_class.count,
            per_page:
          }
        end

        it_behaves_like 'properly renders index endpoint'
      end
    end
  end
end
