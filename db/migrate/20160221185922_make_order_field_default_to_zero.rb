class MakeOrderFieldDefaultToZero < ActiveRecord::Migration
  def change
    change_column :events, :order, :integer, :default => 0
    change_column :scenes, :order, :integer, :default => 0
  end
end
