class Character < ActiveRecord::Base
  belongs_to :story
  has_many :poses
  has_many :events, :through => :poses

  mount_uploader :portrait, PortraitUploader
end
