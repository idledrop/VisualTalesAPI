class Pose < ActiveRecord::Base
  belongs_to :character
  has_many :events, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates_associated :character

  mount_uploader :image, PoseUploader
end
