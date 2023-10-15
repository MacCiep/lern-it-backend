# frozen_string_literal: true

shared_examples 'properly renders index endpoint' do
  it 'returns a 200' do
    expect(response).to have_http_status(:ok)
  end

  it 'returns correct data' do
    expect(response.body).to eq(expected_response.to_json)
  end
end

shared_examples 'record not found' do
  it 'raises RecordNotFound error' do
    expect { request }.to raise_error(ActiveRecord::RecordNotFound)
  end
end

shared_examples 'returns empty data' do
  let(:expected_response) do
    {
      records: {
        data: []
      },
      metadata: {
        total_pages: 1,
        current_page: 1,
        total_count: 0,
        per_page: 20
      }
    }
  end

  it { expect(response.body).to eq(expected_response.to_json) }
end
