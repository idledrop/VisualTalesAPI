class Event < ActiveRecord::Base
  belongs_to :scene
  belongs_to :pose

  validates :position_x, presence: true, numericality: true
  validates :position_y, presence: true, numericality: true
  validates_related :scene
  validates :order, numericality: true
end
