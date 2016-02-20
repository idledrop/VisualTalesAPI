class AddIndexToEventForPose < ActiveRecord::Migration
  def change
    add_index :events, :pose_id
  end
end
