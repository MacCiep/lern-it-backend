# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    respond_to :json
    after_action -> { request.session_options[:skip] = true }
  end
end
