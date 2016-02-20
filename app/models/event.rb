class Event < ActiveRecord::Base
  belongs_to :scene
  belongs_to :pose
end
