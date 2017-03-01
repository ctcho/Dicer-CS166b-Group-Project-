require 'bcrypt'
class User < ApplicationRecord
  has_one :dm_profile
  has_one :player_profile
  has_many :character_sheets

  include BCrypt

  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password_hash, presence: true

  def to_json
    super(:except => :password_hash)
  end

  def password
    @password ||=Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
