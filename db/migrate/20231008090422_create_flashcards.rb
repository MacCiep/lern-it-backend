class CreateFlashcards < ActiveRecord::Migration[7.0]
  def change
    create_table :flashcards do |t|
      t.text :question, max: 60, null: false
      t.text :answer, max: 200, null: false
      t.belongs_to :topic, null: false, foreign_key: true
      t.integer :difficulty, default: 0
      t.integer :correct, default: 0
      t.integer :times_vied, default: 0
      t.timestamps
    end
  end
end
