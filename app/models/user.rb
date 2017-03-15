class User < ApplicationRecord
  attr_accessor :remember_token
  before_save{ self.email = email.downcase}
  has_one :dm_profile
  has_one :player_profile

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates :email, presence: true, uniqueness: {case_sensitive: false},
                    format: {with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_secure_password

  #Search the user database based on the search parameters from search.html.erb
  #Please see search.html.erb for the parameters it sends.
  #Focusing on player/dm profiles individually at the moment. I will expand this. --Cameron C.
  def self.search(parameters)
    ruleset = Integer(parameters[:ruleset1])
    if Integer(parameters[:profile_type]) == 0 #Search the player database
      case ruleset #Since I am currently only searching for most preferred ruleset
      when 1 #Home brew rulesest
        PlayerProfile.where("experience_level = ? AND homebrew = ? AND online_play = ?
        AND module = ?", Integer(parameters[:experience_level]), 1,
        Integer(parameters[:online_play]), Integer(parameters[:module]))
      when 2 #Original ruleset
        PlayerProfile.where("experience_level = ? AND original_ruleset = ? AND online_play = ?
        AND module = ?", Integer(parameters[:experience_level]), 1,
        Integer(parameters[:online_play]), Integer(parameters[:module]))
      when 3 #Advanced Ruleset
        PlayerProfile.where("experience_level = ? AND advanced_ruleset = ? AND online_play = ?
        AND module = ?", Integer(parameters[:experience_level]), 1,
        Integer(parameters[:online_play]), Integer(parameters[:module]))
      when 4 #Pathfinder ruleset
        PlayerProfile.where("experience_level = ? AND pathfinder = ? AND online_play = ?
        AND module = ?", Intger(parameters[:experience_level]), 1,
        Integer(parameters[:online_play]), Integer(parameters[:module]))
      when 5 #Third edition ruleset
        PlayerProfile.where("experience_level = ? AND third = ? AND online_play = ?
        AND module = ?", Integer(parameters[:experience_level]), 1,
        Integer(parameters[:online_play]), Integer(parameters[:module]))
      when 6 #Three.five ruleset
        PlayerProfile.where("experience_level = ? AND three_point_five = ? AND online_play = ?
        AND module = ?", Integer(parameters[:experience_level]), 1,
        Integer(parameters[:online_play]), Integer(parameters[:module]))
      when 7 #Fourth edition ruleset
        PlayerProfile.where("experience_level = ? AND fourth = ? AND online_play = ?
        AND module = ?", Integer(parameters[:experience_level]), 1,
        Integer(parameters[:online_play]), Integer(parameters[:module]))
      when 8 #Fifth edition ruleset
        PlayerProfile.where("experience_level = ? AND fifth = ? AND online_play = ?
        AND module = ?", Integer(parameters[:experience_level]), 1,
        Integer(parameters[:online_play]), Integer(parameters[:module]))
      else #Original Campaign ruleset
        PlayerProfile.where("experience_level = ? AND original_campaign = ? AND online_play = ?
        AND module = ?", Integer(parameters[:experience_level]), 1,
        Integer(parameters[:online_play]), Integer(parameters[:module]))
      end
    else #Searching for DM's
      case ruleset #Since I am currently only searching for most preferred ruleset
      when 1 #Home brew rulesest
        DmProfile.where("experience_level = ? AND homebrew = ? AND online_play = ?
        AND module = ?", Integer(parameters[:experience_level]), 1,
        Integer(parameters[:online_play]), Integer(parameters[:module]))
      when 2 #Original ruleset
        DmProfile.where("experience_level = ? AND original_ruleset = ? AND online_play = ?
        AND module = ?", Integer(parameters[:experience_level]), 1,
        Integer(parameters[:online_play]), Integer(parameters[:module]))
      when 3 #Advanced Ruleset
        DmProfile.where("experience_level = ? AND advanced_ruleset = ? AND online_play = ?
        AND module = ?", Integer(parameters[:experience_level]), 1,
        Integer(parameters[:online_play]), Integer(parameters[:module]))
      when 4 #Pathfinder ruleset
        DmProfile.where("experience_level = ? AND pathfinder = ? AND online_play = ?
        AND module = ?", Integer(parameters[:experience_level]), 1,
        Integer(parameters[:online_play]), Integer(parameters[:module]))
      when 5 #Third edition ruleset
        DmProfile.where("experience_level = ? AND third = ? AND online_play = ?
        AND module = ?", Integer(parameters[:experience_level]), 1,
        Integer(parameters[:online_play]), Integer(parameters[:module]))
      when 6 #Three.five ruleset
        DmProfile.where("experience_level = ? AND three_point_five = ? AND online_play = ?
        AND module = ?", Integer(parameters[:experience_level]), 1,
        Integer(parameters[:online_play]), Integer(parameters[:module]))
      when 7 #Fourth edition ruleset
        DmProfile.where("experience_level = ? AND fourth = ? AND online_play = ?
        AND module = ?", Integer(parameters[:experience_level]), 1,
        Integer(parameters[:online_play]), Integer(parameters[:module]))
      when 8 #Fifth edition ruleset
        DmProfile.where("experience_level = ? AND fifth = ? AND online_play = ?
        AND module = ?", Integer(parameters[:experience_level]), 1,
        Integer(parameters[:online_play]), Integer(parameters[:module]))
      else #Original Campaign ruleset
        DmProfile.where("experience_level = ? AND original_campaign = ? AND online_play = ?
        AND module = ?", Integer(parameters[:experience_level]), 1,
        Integer(parameters[:online_play]), Integer(parameters[:module]))
      end
    end
  end

  def self.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  #forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end

  acts_as_mappable :auto_geocode=>{:field=>:address, :error_message=>'Could not geocode address'}

end
