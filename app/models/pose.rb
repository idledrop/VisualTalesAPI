class Pose < ActiveRecord::Base
  belongs_to :character
  has_many :events

  validates :name, presence: true

  mount_uploader :image, PoseUploader
end
