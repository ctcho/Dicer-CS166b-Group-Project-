class User < ApplicationRecord
  attr_accessor :remember_token
  acts_as_mappable
  before_save{ self.email = email.downcase}
  has_one :dm_profile
  has_one :player_profile

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates :email, presence: true, uniqueness: {case_sensitive: false},
                    format: {with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_secure_password

  def self.location(user, profile_type)
    if Integer(profile_type) == 0 #Player Profiles
      temp = User.joins(:player_profile).within(user.max_distance, origin: user)
      temp.map { |x| x.player_profile }
      #PlayerProfile.within(user.max_distance, origin: user)
    else #DM profiles
      temp = User.joins(:dm_profile).within(user.max_distance, origin: user)
      temp.map { |x| x.dm_profile }
    end
  end

  #If you're worried about all of this code in the model, the professor says it's okay
  #since this only deals with querying the database for other users. --Cameron C.

  #Search the user database based on the search parameters from search.html.erb
  #Please see search.html.erb for the parameters it sends.
  #As of 3/24/2017, I made the search more secure by preventing the possibility
  #of SQL injection.
  #Focusing on player/dm profiles individually at the moment. I will expand this. --Cameron C.
  def self.search(parameters)
    ruleset = Integer(parameters[:ruleset1])
    if Integer(parameters[:profile_type]) == 0 #Search the player database
      case ruleset #Since I am currently only searching for most preferred ruleset
      when 1 #Home brew rulesest
        PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
        homebrew: 1, online_play: Integer(parameters[:online_play]), module: Integer(parameters[:module]))
      when 2 #Original ruleset
        PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
        original_ruleset: 1, online_play: Integer(parameters[:online_play]), module: Integer(parameters[:module]))
      when 3 #Advanced Ruleset
        PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
        advanced_ruleset: 1, online_play: Integer(parameters[:online_play]), module: Integer(parameters[:module]))
      when 4 #Pathfinder ruleset
        PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
        pathfinder: 1, online_play: Integer(parameters[:online_play]), module: Integer(parameters[:module]))
      when 5 #Third edition ruleset
        PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
        third: 1, online_play: Integer(parameters[:online_play]), module: Integer(parameters[:module]))
      when 6 #Three.five ruleset
        PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
        three_point_five: 1, online_play: Integer(parameters[:online_play]), module: Integer(parameters[:module]))
      when 7 #Fourth edition ruleset
        PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
        fourth: 1, online_play: Integer(parameters[:online_play]), module: Integer(parameters[:module]))
      when 8 #Fifth edition ruleset
        PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
        fifth: 1, online_play: Integer(parameters[:online_play]), module: Integer(parameters[:module]))
      else #Original Campaign ruleset
        PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
        original_campaign: 1, online_play: Integer(parameters[:online_play]), module: Integer(parameters[:module]))
      end
    else #Searching for DM's
      case ruleset #Since I am currently only searching for most preferred ruleset
      when 1 #Home brew rulesest
        DmProfile.where(experience_level: Integer(parameters[:experience_level]),
        homebrew: 1, online_play: Integer(parameters[:online_play]), module: Integer(parameters[:module]))
      when 2 #Original ruleset
        DmProfile.where(experience_level: Integer(parameters[:experience_level]),
        original_ruleset: 1, online_play: Integer(parameters[:online_play]), module: Integer(parameters[:module]))
      when 3 #Advanced Ruleset
        DmProfile.where(experience_level: Integer(parameters[:experience_level]),
        advanced_ruleset: 1, online_play: Integer(parameters[:online_play]), module: Integer(parameters[:module]))
      when 4 #Pathfinder ruleset
        DmProfile.where(experience_level: Integer(parameters[:experience_level]),
        pathfinder: 1, online_play: Integer(parameters[:online_play]), module: Integer(parameters[:module]))
      when 5 #Third edition ruleset
        DmProfile.where(experience_level: Integer(parameters[:experience_level]),
        third: 1, online_play: Integer(parameters[:online_play]), module: Integer(parameters[:module]))
      when 6 #Three.five ruleset
        DmProfile.where(experience_level: Integer(parameters[:experience_level]),
        three_point_five: 1, online_play: Integer(parameters[:online_play]), module: Integer(parameters[:module]))
      when 7 #Fourth edition ruleset
        DmProfile.where(experience_level: Integer(parameters[:experience_level]),
        fourth: 1, online_play: Integer(parameters[:online_play]), module: Integer(parameters[:module]))
      when 8 #Fifth edition ruleset
        DmProfile.where(experience_level: Integer(parameters[:experience_level]),
        fifth: 1, online_play: Integer(parameters[:online_play]), module: Integer(parameters[:module]))
      else #Original Campaign ruleset
        DmProfile.where(experience_level: Integer(parameters[:experience_level]),
        original_campaign: 1, online_play: Integer(parameters[:online_play]), module: Integer(parameters[:module]))
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
