class Story < ActiveRecord::Base
  has_many :characters, dependent: :destroy
  has_many :story_tags, dependent: :destroy
  has_many :tags, :through => :story_tags
  has_many :scenes, dependent: :destroy

  validates :author, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 255 }
  validates_format_of :email, :with => /.+@.+\..+/i
  validates :email, length: { maximum: 255 }


end
