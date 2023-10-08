# frozen_string_literal: true

module Api
  module V1
    class FlashcardsController < ApiController
      def index
        @records = current_user.flashcards
        render json: paginated_response(serializer: FlashcardSerializer), status: :ok
      end

      def create
        current_user.topics.find(flashcard_params[:topic_id])
        flashcard = current_user.flashcards.build(flashcard_params)
        if flashcard.save
          render json: FlashcardSerializer.new(flashcard).serializable_hash.to_json, status: :created
        else
          render json: { errors: flashcard.errors }, status: :unprocessable_entity
        end
      end

      def update
        flashcard = current_user.flashcards.find(params[:id])
        if flashcard.update(flashcard_params)
          render json: FlashcardSerializer.new(flashcard).serializable_hash.to_json, status: :ok
        else
          render json: { errors: flashcard.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        flashcard = current_user.flashcards.find(params[:id])
        if flashcard.destroy
          head :no_content
        else
          render json: { errors: flashcard.errors }, status: :unprocessable_entity
        end
      end

      private

      def flashcard_params
        params.require(:flashcard).permit(:question, :answer, :topic_id, :difficulty)
      end
    end
  end
end
