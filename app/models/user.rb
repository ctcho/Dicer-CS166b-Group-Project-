class User < ApplicationRecord



  has_one :dm_profile
  has_one :player_profile

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates :email, presence: true, uniqueness: {case_sensitive: false},
                    format: {with: VALID_EMAIL_REGEX }

  has_secure_password


end
