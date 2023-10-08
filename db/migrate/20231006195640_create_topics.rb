class CreateTopics < ActiveRecord::Migration[7.0]
  def change
    create_table :topics do |t|
      t.string :title, null: false, index: { unique: true }
      t.belongs_to :user, null: false, foreign_key: true, index: true
      t.timestamps
    end
  end
end
