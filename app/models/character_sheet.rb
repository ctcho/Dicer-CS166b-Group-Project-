class CharacterSheet < ApplicationRecord
  belongs_to :player_profile

  validates :file_path, presence: true
end
