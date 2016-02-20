class CreateStoryTags < ActiveRecord::Migration
  def change
    create_table :story_tags do |t|
      t.references :story, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
