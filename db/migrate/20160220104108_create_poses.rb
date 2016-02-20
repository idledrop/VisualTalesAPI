class CreatePoses < ActiveRecord::Migration
  def change
    create_table :poses do |t|
      t.string :name
      t.string :image
      t.references :character, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
