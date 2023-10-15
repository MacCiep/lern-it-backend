class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.belongs_to :topic, null: false, foreign_key: true
      t.integer :priority, default: 0
      t.string :title, null: false
      t.text :description, max: 200
      t.timestamps
    end
  end
end
