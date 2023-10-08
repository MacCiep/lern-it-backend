# frozen_string_literal: true

module Api
  module V1
    class TopicsController < ApiController
      def index
        @records = current_user.topics
        render json: paginated_response(serializer: TopicSerializer), status: :ok
      end

      def create
        topic = current_user.topics.build(topic_params)
        if topic.save
          render json: TopicSerializer.new(topic).serializable_hash.to_json, status: :created
        else
          render json: { errors: topic.errors }, status: :unprocessable_entity
        end
      end

      def update
        topic = current_user.topics.find(params[:id])
        if topic.update(topic_params)
          render json: TopicSerializer.new(topic).serializable_hash.to_json, status: :ok
        else
          render json: { errors: topic.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        topic = current_user.topics.find(params[:id])
        if topic.destroy
          head :no_content
        else
          render json: { errors: topic.errors }, status: :unprocessable_entity
        end
      end

      def topic_params
        params.require(:topic).permit(:title)
      end
    end
  end
end
