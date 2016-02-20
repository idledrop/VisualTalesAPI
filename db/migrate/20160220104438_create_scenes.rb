class CreateScenes < ActiveRecord::Migration
  def change
    create_table :scenes do |t|
      t.string :name
      t.string :description
      t.string :background
      t.references :story, index: true, foreign_key: true
      t.integer :order

      t.timestamps null: false
    end
  end
end
