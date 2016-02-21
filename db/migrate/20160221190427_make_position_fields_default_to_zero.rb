class MakePositionFieldsDefaultToZero < ActiveRecord::Migration
  def change
    change_column :events, :position_x, :integer, :default => 0
    change_column :events, :position_y, :integer, :default => 0
  end
end
