# frozen_string_literal: true

require 'devise/jwt/test_helpers'

module ApiHelper
  # :reek:UtilityFunction
  def authenticated_headers(headers, user)
    headers['Accept'] = 'application/json'
    Devise::JWT::TestHelpers.auth_headers(headers, user, scope: :user)
  end
end

RSpec.configure do |config|
  config.include(ApiHelper)
end
