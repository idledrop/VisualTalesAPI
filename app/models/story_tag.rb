class StoryTag < ActiveRecord::Base
  belongs_to :story
  belongs_to :tag

  validates :story_id, uniqueness: { scope: :tag_id }
end
