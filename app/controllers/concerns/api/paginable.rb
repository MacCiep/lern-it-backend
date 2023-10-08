module Api::Paginable
  extend ActiveSupport::Concern

  def paginated_response(serializer: nil)
    @pagy_instance, @scope = pagy(@records, page: params[:page], items: params[:per_page])
    @scope = serializer.new(@scope).serializable_hash if serializer.present?
    { records: @scope, metadata: normalized_pagy_metadata(@pagy_instance)}
  end
end