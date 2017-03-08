class PlayerProfile < ApplicationRecord
  belongs_to :user
  has_many :character_sheets
  acts_as_mappable :through => :user

  validates :bio, presence: true
  validates :experience_level, presence: true
end
