class MakeDescriptionFieldsTypeText < ActiveRecord::Migration
  def change
    change_column :characters, :description, :text
    change_column :scenes, :description, :text
    change_column :stories, :description, :text
  end
end
