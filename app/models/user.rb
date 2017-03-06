class User < ApplicationRecord

  has_secure_password

  has_one :dm_profile
  has_one :player_profile

  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password_digest, presence: true

  def to_json
    super(:except => :password_digest)
  end

end
