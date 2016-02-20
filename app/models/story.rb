class Story < ActiveRecord::Base
  validates :author, presence: true
  validates :title, presence: true
  validates_format_of :email, :with => /.+@.+\..+/i

  has_many :characters
  has_many :story_tags
  has_many :tags, :through => :story_tags
  has_many :scenes
end
