class DmProfile < ApplicationRecord
  belongs_to :user
  validates :bio, presence: true
  validates :experience_level, presence: true
end
