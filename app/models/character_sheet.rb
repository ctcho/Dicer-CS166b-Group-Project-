class CharacterSheet < ApplicationRecord
  belongs_to :user
  validates :filename, presence: true
  validates :bio, presence: true
end
