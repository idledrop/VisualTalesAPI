class Scene < ActiveRecord::Base
  belongs_to :story
  has_many :events
  has_many :poses, :through => :events
  has_many :characters, -> { uniq }, :through => :poses

  validates :order, presence: true
  validates :order, uniqueness: { scope: :story_id}
  validates :name, presence: true


  mount_uploader :background, BackgroundUploader
end
