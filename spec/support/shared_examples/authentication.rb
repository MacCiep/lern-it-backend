# frozen_string_literal: true

shared_examples 'response status' do |status|
  it "responds with #{status}" do
    expect(response).to have_http_status(status)
  end
end

shared_examples 'protected endpoint' do |method:, url:|
  subject { send(method, url, headers:) }

  let(:headers) { { accept: 'application/json' } }
  let(:user) { create(:user) }

  context 'when authorization header is missing' do
    before { subject }

    it_behaves_like 'response status', :unauthorized
  end

  context 'when authorization header is present' do
    context 'when access token is valid' do
      subject do
        send(method, url, headers:)
      rescue StandardError
        nil
      end

      let(:headers) { authenticated_headers({}, user) }

      before { subject }

      it { expect(response).not_to have_http_status(:unauthorized) }
      it { expect(response).not_to have_http_status(:forbidden) }
    end

    context 'when access token is invalid' do
      let(:access_token) { 'Wrong access token' }
      let(:headers) { { accept: 'application/json', authorization: "Bearer #{access_token}" } }

      before { subject }

      it_behaves_like 'response status', :unauthorized
    end

    context 'when access token expired' do
      let(:headers) { authenticated_headers({}, user) }

      before do
        headers
        Timecop.travel(ENV['DEVISE_JWT_EXPIRATION_TIME'].to_i + 1.second)
        subject
      end

      it_behaves_like 'response status', :unauthorized
    end
  end
end
