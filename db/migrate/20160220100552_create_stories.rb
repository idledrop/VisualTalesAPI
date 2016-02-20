class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.string :author
      t.string :email
      t.string :description

      t.timestamps null: false
    end
  end
end
