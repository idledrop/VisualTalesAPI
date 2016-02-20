class Scene < ActiveRecord::Base
  belongs_to :story
  has_many :events
  has_many :poses, :through => :events
  has_many :characters, -> { uniq }, :through => :poses

  mount_uploader :background, BackgroundUploader
end
