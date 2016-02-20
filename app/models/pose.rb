class Pose < ActiveRecord::Base
  belongs_to :character
  has_many :events

  mount_uploader :image, PoseUploader
end
