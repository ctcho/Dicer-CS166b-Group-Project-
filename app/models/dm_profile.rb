class DmProfile < ApplicationRecord
  belongs_to :user
  validates :bio, presence: true
  validates :experience_level, presence: true
  acts_as_mappable :through => :user
end
