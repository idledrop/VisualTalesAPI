class Scene < ActiveRecord::Base
  belongs_to :story
  has_many :events, dependent: :destroy
  has_many :poses, :through => :events
  has_many :characters, -> { uniq }, :through => :poses

  validates :order, numericality: true
  validates :name, presence: true, length: { maximum: 255 }
  validates_associated :story

  mount_uploader :background, BackgroundUploader
end
