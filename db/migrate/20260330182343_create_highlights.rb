class CreateHighlights < ActiveRecord::Migration
  def change
    create_table :highlights do |t|
      t.references :user, index: true, foreign_key: true
      t.references :article, index: true, foreign_key: true
      t.text :content
      t.integer :position

      t.timestamps null: false
    end
  end
end
