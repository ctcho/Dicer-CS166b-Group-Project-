module SearchPagesHelper
include UsersHelper
#include SessionsHelper

  def has_valid_users(search_results)
    results = search_results.count
    search_results.each do |user|
      if user.user == current_user || !within_distance(current_user, user.user)
        results -= 1
      end
    end
    return results != 0
  end

  def parse_results(searches, user)
    set = []
    searches.each do |profile|
      #byebug
      if profile.user != user && within_distance(user, profile.user)
        set << profile
      end
    end
    return set
  end

  def recommend_set(recommend_search_results, viewed_user)
    limit = 4
    set = []
    recommend_search_results.each do |profile|
      #byebug
      if profile.user != current_user && profile.user != viewed_user && within_distance(current_user, profile.user) && (profile.user.age - viewed_user.age).abs <= 3 && limit > 0
        set << profile
        limit = limit - 1
      end
    end
    return set
  end

  def search_checksum(search_params)
    filtered = Hash.new
    search_params.each do |param|
      if !param.nil?
        filtered = filtered.merge(param)
      end
    end
    return filtered
  end

  def sort_results(unsorted_profiles, search_filter)
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

#Below is all of the methods that parse through the given search parameters.

  #This happens often enough to put it in its own method...
  def searching_rulesets(rulesets, profile_type, option)
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

  def ruleset_parse(rulesets)
    #puts "#{rulesets}"
    compiled = []
    rulesets.each do |r|
      if !r.nil?
        if r == "homebrew" #homebrew
          compiled << {homebrew: 1}
          #puts "Homebrew"
        elsif r == "original_ruleset" #original_ruleset
          compiled << {original_ruleset: 1}
          #puts "Original Ruleset"
        elsif r == "advanced_ruleset" #advanced_ruleset
          compiled << {advanced_ruleset: 1}
          #puts "Advanced Ruleset"
        elsif r == "pathfinder" #Pathfinder
          compiled << {pathfinder: 1}
          #puts "Pathfinder"
        elsif r == "third" #third
          compiled << {third: 1}
          #puts "Third"
        elsif r == "three_point_five" #three_point_five
          compiled << {three_point_five: 1}
          #puts "Three point five"
        elsif r == "fourth" #fourth
          compiled << {fourth: 1}
          #puts "Fourth"
        elsif r == "fifth" #fifth
          compiled << {fifth: 1}
          #puts "Fifth"
        end
      end
    end
    return compiled
  end

  def campaign_parse(campaign_id)
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

  def exp_parse(experience)
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

  def online_parse(on)
    line = Hash.new
    if on == "0" #Does not like online play
      line = {online_play: 0}
    elsif on == "1" #Does like online play
      line = {online_play: 1}
    end
    return line
  end

  def rule_recom_parse(rulesets)
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

end
