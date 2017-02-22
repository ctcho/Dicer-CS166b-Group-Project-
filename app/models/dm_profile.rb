class DmProfile < ApplicationRecord
  belongs_to :user
  validates :bio, presence: true
  validates :exp_level, presence: true
end
