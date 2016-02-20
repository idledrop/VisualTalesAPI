class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.string :description
      t.string :portrait
      t.references :story, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
