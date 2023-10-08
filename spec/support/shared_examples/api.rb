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
