class PlayerProfile < ApplicationRecord
  belongs_to :user
  has_many :character_sheets

  validates :bio, presence: true
  validates :experience_level, presence: true
end
