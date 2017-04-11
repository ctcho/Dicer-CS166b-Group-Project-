class User < ApplicationRecord
  has_attached_file :avatar, styles: { medium: "175x175>", thumb: "75x75>" }, default_url: "dicepic175.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 1.megabytes
  attr_accessor :remember_token
  acts_as_mappable
  before_save{ self.email = email.downcase}
  has_one :dm_profile
  has_one :player_profile
  has_many :messages
  has_and_belongs_to_many :chat_rooms

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates :email, presence: true, uniqueness: {case_sensitive: false},
                    format: {with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_secure_password



  def self.location(user, profile_type)
    if profile_type == "0" #Player Profiles
      #byebug
      in_range = User.joins(:player_profile).within(user.max_distance, origin: user)
      in_range.map { |x| x.player_profile }
      #PlayerProfile.within(user.max_distance, origin: user)
    else #DM profiles
      in_range = User.joins(:dm_profile).within(user.max_distance, origin: user)
      in_range.map { |x| x.dm_profile }
    end
  end

  #Search the user database based on the search parameters from search.html.erb
  #Please see search.html.erb for the parameters it sends.
  #As of 3/24/2017, I made the search more secure by preventing the possibility
  #of SQL injection.
  #Focusing on player/dm profiles individually at the moment. I will expand this. --Cameron C.
  def self.search(parameters)
    rulesets = []
    #rulesets = ruleset_parse([parameters[:ruleset1], parameters[:ruleset2], parameters[:ruleset3]])
    campaign_types = campaign_parse(parameters[:campaign_type])
    exp_level = exp_parse(parameters[:experience_level])
    online = online_parse(parameters[:online_play])
    rulesets = ruleset_parse([parameters[:homebrew], parameters[:original_ruleset], parameters[:advanced_ruleset],
    parameters[:pathfinder], parameters[:third], parameters[:three_point_five], parameters[:fourth],
    parameters[:fifth]])
    #if rulesets.nil?
    #byebug
    if parameters[:profile_type] == "0" #Search the player database
      PlayerProfile.where(exp_level[:level])
      .merge(PlayerProfile.where(online[:on_line]))
      .merge(PlayerProfile.where(campaign_types[:campaign]))
      .merge(PlayerProfile.where(rulesets[0])
      .merge(PlayerProfile.where(rulesets[1]))
      .merge(PlayerProfile.where(rulesets[2]))
      .merge(PlayerProfile.where(rulesets[3]))
      .merge(PlayerProfile.where(rulesets[4]))
      .merge(PlayerProfile.where(rulesets[5]))
      .merge(PlayerProfile.where(rulesets[6]))
      .merge(PlayerProfile.where(rulesets[7]))
      )
    else #Searching for DM's
      DmProfile.where(exp_level[:level])
      .merge(DmProfile.where(online[:on_line]))
      .merge(DmProfile.where(campaign_types[:campaign]))
      .merge(DmProfile.where(rulesets[0])
      .merge(DmProfile.where(rulesets[1]))
      .merge(DmProfile.where(rulesets[2]))
      .merge(DmProfile.where(rulesets[3]))
      .merge(DmProfile.where(rulesets[4]))
      .merge(DmProfile.where(rulesets[5]))
      .merge(DmProfile.where(rulesets[6]))
      .merge(DmProfile.where(rulesets[7]))
      )
    end
  end

  def self.ruleset_parse(rulesets)
    #puts "#{rulesets}"
    compiled = []
    rulesets.each do |r|
      if !r.nil?
        if r == "1" #homebrew
          compiled << {homebrew: 1}
          #puts "Homebrew"
        elsif r == "2" #original_ruleset
          compiled << {original_ruleset: 1}
          #puts "Original Ruleset"
        elsif r == "3" #advanced_ruleset
          compiled << {advanced_ruleset: 1}
          #puts "Advanced Ruleset"
        elsif r == "4" #Pathfinder
          compiled << {pathfinder: 1}
          #puts "Pathfinder"
        elsif r == "5" #third
          compiled << {third: 1}
          #puts "Third"
        elsif r == "6" #three_point_five
          compiled << {three_point_five: 1}
          #puts "Three point five"
        elsif r == "7" #fourth
          compiled << {fourth: 1}
          #puts "Fourth"
        elsif r == "8" #fifth
          compiled << {fifth: 1}
          #puts "Fifth"
        end
      end
    end
    return compiled
  end

  def self.campaign_parse(campaign_id)
    #puts "#{campaign_id}"
    selected = Hash.new
    if campaign_id == "0" #original_campaign
      selected[:campaign] = {original_campaign: 1}
    elsif campaign_id == "1" #module
      selected[:campaign] = {module: 1}
    end
    return selected
  end

  def self.exp_parse(experience)
    exp = Hash.new
    if experience == "1" #New
      exp[:level] = {experience_level: 1}
    elsif experience == "2" #Novice
      exp[:level] = {experience_level: 2}
    elsif experience == "3" #Experienced
      exp[:level] = {experience_level: 3}
    elsif experience == "4" #Veteran
      exp[:level] = {experience_level: 4}
    end
    return exp
  end

  def self.online_parse(on)
    line = Hash.new
    if on == "0" #Does not like online play
      line[:on_line] = {online_play: 0}
    elsif on == "1" #Does like online play
      line[:on_line] = {online_play: 1}
    end
    return line
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
