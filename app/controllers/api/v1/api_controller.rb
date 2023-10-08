module Api
  module V1
    class ApiController < ApplicationController
      respond_to :json
      include ::Api::Paginable

      before_action :authenticate_user!

      include Pagy::Backend
    end
  end
end