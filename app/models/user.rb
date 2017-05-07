include SearchPagesHelper
class User < ApplicationRecord
  has_attached_file :avatar, styles: { medium: "175x175>", thumb: "100x100>", smallerthumb: "35x35>"}, default_url: ":style/dicepic.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 1.megabytes
  attr_accessor :remember_token
  acts_as_mappable
  before_save { self.email = email.downcase}
  has_one :dm_profile
  has_one :player_profile
  has_many :messages
  #has_and_belongs_to_many :chat_rooms
  has_many :chat_rooms_users
  has_many :chat_rooms, through: :chat_rooms_users

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates :email, presence: true, uniqueness: {case_sensitive: false},
                    format: {with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_secure_password

  def self.recommender(profile, type)
    rulesets = []
    rulesets = rule_recom_parse([profile.homebrew, profile.original_ruleset, profile.advanced_ruleset,
    profile.pathfinder, profile.third, profile.three_point_five, profile.fourth, profile.fifth])
    filter = search_checksum(rulesets)
    if type == "player"
      result = PlayerProfile.where(experience_level: profile.experience_level)
      .or(searching_rulesets(rulesets, "0", "OR"))
    else #DM profile
      result = DmProfile.where(experience_level: profile.experience_level)
      .or(searching_rulesets(rulesets, "1", "OR"))
    end
    return sort_results(result, filter)
  end

  def self.location(user, profile_type)
    if profile_type == "0" #Player Profiles
      in_range = User.joins(:player_profile).within(user.max_distance, origin: user)
      in_range.map { |x| x.player_profile }
    else #DM profiles or the user decided not to search for anyone...
      in_range = User.joins(:dm_profile).within(user.max_distance, origin: user)
      in_range.map { |x| x.dm_profile }
    end
  end

  #Search the user database based on the search parameters from search.html.erb
  #Please see search.html.erb for the parameters it sends.
  #As of 3/24/2017, I made the search more secure by preventing the possibility
  #of SQL injection.
  #Focusing on player/dm profiles individually at the moment. I will expand this. --Cameron C.
  def self.search(parameters, user)
    rulesets = []
    campaign_types = campaign_parse(parameters[:campaign_type])
    exp_level = exp_parse(parameters[:experience_level])
    online = online_parse(parameters[:online_play])
    rulesets = ruleset_parse([parameters[:homebrew], parameters[:original_ruleset], parameters[:advanced_ruleset],
    parameters[:pathfinder], parameters[:third], parameters[:three_point_five], parameters[:fourth],
    parameters[:fifth]])
    filter = search_checksum([exp_level] + [campaign_types] + [online] + rulesets)
    if parameters[:option] != "OR" # Search for all of the listed conditions
      if parameters[:profile_type] != "1" #Search the player database
        result = PlayerProfile.where(exp_level)
        .merge(PlayerProfile.where(online))
        .merge(PlayerProfile.where(campaign_types))
        .merge(searching_rulesets(rulesets, parameters[:profile_type], parameters[:option]))
        return parse_results(result, user)
      else #Searching for DM's
        result = DmProfile.where(exp_level)
        .merge(DmProfile.where(online))
        .merge(DmProfile.where(campaign_types))
        .merge(searching_rulesets(rulesets, parameters[:profile_type], parameters[:option]))
        return parse_results(result, user)
      end
    else #Search for any of the listed conditions
      if parameters[:profile_type] != "1" #Search the player database
        results = PlayerProfile.where(exp_level)
        .or(PlayerProfile.where(online))
        .or(PlayerProfile.where(campaign_types))
        .or(searching_rulesets(rulesets, parameters[:profile_type], parameters[:option]))
        results = sort_results(results, filter)
        return parse_results(results, user)
      else #Searching for DM's
        results = DmProfile.where(exp_level)
        .or(DmProfile.where(online))
        .or(DmProfile.where(campaign_types))
        .or(searching_rulesets(rulesets, parameters[:profile_type], parameters[:option]))
        results = sort_results(results, filter)
        return parse_results(results, user)
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
