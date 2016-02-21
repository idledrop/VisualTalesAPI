class Tag < ActiveRecord::Base
  has_many :story_tags, :dependent => :destroy
  has_many :stories, :through => :story_tags

  validates :name, presence: true
  validates :name, uniqueness: true
end
