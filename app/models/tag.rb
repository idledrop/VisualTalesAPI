class Tag < ActiveRecord::Base
  has_many :story_tags, :dependent => :destroy
  has_many :stories, :through => :story_tags

  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }

  #before_save :squash_tag

  #def squash_tag
  #  self.name = name.downcase.gsub(/\s+/, "")
  #end
end
