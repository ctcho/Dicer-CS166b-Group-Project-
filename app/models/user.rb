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
  has_many :chat_rooms_users
  has_many :chat_rooms, through: :chat_rooms_users
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :blockings
  has_many :blockeds, through: :blockings

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates :email, presence: true, uniqueness: {case_sensitive: false},
                    format: {with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_secure_password

  #Facebook Schtuff. Hope it works.
  def self.koala(auth)
    access_token = auth['token']
    facebook = Koala::Facebook::API.new(access_token)
    profile = facebook.get_object("me")
    fb_uid = profile["id"]
    friends = facebook.get_connections("me", "friends")
    friend_ids = friends.collect { |f| f["id"] }
    [fb_uid, friend_ids]
  end

  def online?
    !Redis.new.get("user_#{self.id}_online").nil?
  end

  def self.recommender(profile, type)
    if profile.nil?
      return nil
    end
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
    #rulesets = ruleset_parse([parameters[:ruleset1], parameters[:ruleset2], parameters[:ruleset3]])
    campaign_types = campaign_parse(parameters[:campaign_type])
    exp_level = exp_parse(parameters[:experience_level])
    online = online_parse(parameters[:online_play])
    rulesets = ruleset_parse([parameters[:homebrew], parameters[:original_ruleset], parameters[:advanced_ruleset],
    parameters[:pathfinder], parameters[:third], parameters[:three_point_five], parameters[:fourth],
    parameters[:fifth]])
    filter = search_checksum([exp_level] + [campaign_types] + [online] + rulesets)
    #byebug
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

#Contained within these lines are all methods to help with the search.
#----------------------------------------------------------------------------------------------------------------
  def self.parse_results(searches, user)
    set = []
    searches.each do |profile|
      #byebug
      if profile.user != user && within_distance(user, profile.user) && !user.blocked_by?(profile.user)
        set << profile
        end
      end
      return set
    end

    def self.search_checksum(search_params)
      filtered = Hash.new
      search_params.each do |param|
        if !param.nil?
          filtered = filtered.merge(param)
        end
      end
      return filtered
    end

    def self.sort_results(unsorted_profiles, search_filter)
      counter = 0
      profile_type = ""
      if unsorted_profiles.class == PlayerProfile::ActiveRecord_Relation
        profile_type = "player"
      else #Is DmProfile::ActiveRecord_Relation
        profile_type = "dm"
      end
      sorted_profiles = unsorted_profiles.as_json
      sorted_profiles.each do |profile|
        profile["check_sum"] = 0
        search_filter.each do |spec|
          if profile.include?(spec[0].to_s)
            if profile[spec[0].to_s] == spec[1]
              profile["check_sum"] = profile["check_sum"] + 1
            end
          end
        end
      end
      sorted_profiles = sorted_profiles.sort { |a, b| b["check_sum"] <=> a["check_sum"] }
      if profile_type == "player"
        result = []
        sorted_profiles.each do |pro|
          result << PlayerProfile.find(pro["id"])
        end
        return result
      else # profile_type == "dm"
        result = []
        sorted_profiles.each do |pro|
          result << DmProfile.find(pro["id"])
        end
        return result
      end
    end

    #This happens often enough to put it in its own method...
    def self.searching_rulesets(rulesets, profile_type, option)
      if option != "OR" #option is "AND" and all of the conditions apply
        if profile_type != "1" #Searching for Players
          return PlayerProfile.where(rulesets[0])
          .merge(PlayerProfile.where(rulesets[1]))
          .merge(PlayerProfile.where(rulesets[2]))
          .merge(PlayerProfile.where(rulesets[3]))
          .merge(PlayerProfile.where(rulesets[4]))
          .merge(PlayerProfile.where(rulesets[5]))
          .merge(PlayerProfile.where(rulesets[6]))
          .merge(PlayerProfile.where(rulesets[7]))
        else #Searching for DM's
          return DmProfile.where(rulesets[0])
          .merge(DmProfile.where(rulesets[1]))
          .merge(DmProfile.where(rulesets[2]))
          .merge(DmProfile.where(rulesets[3]))
          .merge(DmProfile.where(rulesets[4]))
          .merge(DmProfile.where(rulesets[5]))
          .merge(DmProfile.where(rulesets[6]))
          .merge(DmProfile.where(rulesets[7]))
        end
      else #option is "OR" and any of the conditions apply
        if profile_type != "1" #Searching for Players
          return PlayerProfile.where(rulesets[0])
          .or(PlayerProfile.where(rulesets[1]))
          .or(PlayerProfile.where(rulesets[2]))
          .or(PlayerProfile.where(rulesets[3]))
          .or(PlayerProfile.where(rulesets[4]))
          .or(PlayerProfile.where(rulesets[5]))
          .or(PlayerProfile.where(rulesets[6]))
          .or(PlayerProfile.where(rulesets[7]))
        else #Searching for DM's
          return DmProfile.where(rulesets[0])
          .or(DmProfile.where(rulesets[1]))
          .or(DmProfile.where(rulesets[2]))
          .or(DmProfile.where(rulesets[3]))
          .or(DmProfile.where(rulesets[4]))
          .or(DmProfile.where(rulesets[5]))
          .or(DmProfile.where(rulesets[6]))
          .or(DmProfile.where(rulesets[7]))
        end
      end
    end

    def self.ruleset_parse(rulesets)
      compiled = []
      rulesets.each do |r|
        if !r.nil?
          if r == "1" #homebrew
            compiled << {homebrew: 1}
          elsif r == "2" #original_ruleset
            compiled << {original_ruleset: 1}
          elsif r == "3" #advanced_ruleset
            compiled << {advanced_ruleset: 1}
          elsif r == "4" #Pathfinder
            compiled << {pathfinder: 1}
          elsif r == "5" #third
            compiled << {third: 1}
          elsif r == "6" #three_point_five
            compiled << {three_point_five: 1}
          elsif r == "7" #fourth
            compiled << {fourth: 1}
          elsif r == "8" #fifth
            compiled << {fifth: 1}
          end
        end
      end
      return compiled
    end

    def self.campaign_parse(campaign_id)
      #puts "#{campaign_id}"
      selected = Hash.new
      if campaign_id == "0" #original_campaign
        selected = {original_campaign: 1}
      elsif campaign_id == "1" #module
        selected = {module: 1}
        #The user has expressed no preference for campaigns otherwise.
      end
      return selected
    end

    def self.exp_parse(experience)
      exp = Hash.new
      if experience == "1" #New
        exp = {experience_level: 1}
      elsif experience == "2" #Novice
        exp = {experience_level: 2}
      elsif experience == "3" #Experienced
        exp = {experience_level: 3}
      elsif experience == "4" #Veteran
        exp = {experience_level: 4}
      end
      return exp
    end

    def self.online_parse(on)
      line = Hash.new
      if on == "0" #Does not like online play
        line = {online_play: 0}
      elsif on == "1" #Does like online play
        line = {online_play: 1}
      end
      return line
    end

    def self.rule_recom_parse(rulesets)
      preferred = []
      i = 1
      rulesets.each do |r|
        if r == 1 #Profile likes this particular ruleset
          if i == 1
            preferred << {homebrew: 1}
          elsif i == 2
            preferred << {original_ruleset: 1}
          elsif i == 3
            preferred << {advanced_ruleset: 1}
          elsif i == 4
            preferred << {pathfinder: 1}
          elsif i == 5
            preferred << {third: 1}
          elsif i == 6
            preferred << {three_point_five: 1}
          elsif i == 7
            preferred << {fourth: 1}
          else
            preferred << {fifth: 1}
          end
        else #Profile does not like this particular ruleset
          preferred << nil
        end
        i += 1
      end
      return preferred
    end

  #----------------------------------------------------------------------------------------------------------------

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

  def friends_with?(user)
    self.friends.include? user
  end

  def blocked_by?(user)
    user.blockeds.include? self
  end
  acts_as_mappable :auto_geocode=>{:field=>:address, :error_message=>'Could not geocode address'}

end
