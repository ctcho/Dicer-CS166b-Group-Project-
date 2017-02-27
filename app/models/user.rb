
class User < ApplicationRecord

  has_secure_password

  has_one :dm_profile
  has_one :player_profile
  has_many :character_sheets


  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, presence: true

  def to_json
    super(:except => :password)
  end

end

puts to_json
