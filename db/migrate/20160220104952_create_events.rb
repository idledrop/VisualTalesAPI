class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :pose
      t.integer :position_x
      t.integer :position_y
      t.text :script
      t.references :scene, index: true, foreign_key: true
      t.integer :order

      t.timestamps null: false
    end
  end
end
