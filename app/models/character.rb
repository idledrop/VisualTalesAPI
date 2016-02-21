class Character < ActiveRecord::Base
  belongs_to :story
  has_many :poses, dependent: :destroy
  has_many :events, :through => :poses

  validates :name, presence: true, length: { maximum: 255 }

  mount_uploader :portrait, PortraitUploader
end
