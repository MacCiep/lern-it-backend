module Api
  module V1
    class NotesController < ApiController
      def index
        @records = current_user.notes
        render json: paginated_response(serializer: NoteSerializer), status: :ok
      end

      def create
        note = current_user.notes.build(note_params)

        if note.save
          render json: NoteSerializer.new(note).serializable_hash, status: :created
        else
          render json: { errors: note.errors }, status: :unprocessable_entity
        end
      end

      def update
        note = current_user.notes.find(params[:id])

        if note.update(note_params)
          render json: NoteSerializer.new(note).serializable_hash, status: :ok
        else
          render json: { errors: note.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        note = current_user.notes.find(params[:id])
        if note.destroy
          head :no_content
        else
          render json: { errors: note.errors }, status: :unprocessable_entity
        end
      end

      private

      def note_params
        params.permit(:title, :priority, :topic_id, :file, :description)
      end
    end
  end
end