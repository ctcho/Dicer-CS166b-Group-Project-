module SearchPagesHelper
include UsersHelper

  def has_valid_users(search_results)
    results = search_results.count
    search_results.each do |user|
      if user.user == current_user || !within_distance(current_user, user.user)
        results -= 1
      end
    end
    return results != 0
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
    #puts search_filter
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
      #keys = search_filter.keys
      search_filter.each do |spec|
        #puts spec
        if profile.include?(spec[0].to_s)
          if profile[spec[0].to_s] == spec[1]
            profile["check_sum"] = profile["check_sum"] + 1
          end
        end
      end
      #puts "How well does profile #{profile["id"]} match? #{profile["check_sum"]}"
    end
    sorted_profiles = sorted_profiles.sort { |a, b| b["check_sum"] <=> a["check_sum"] }
    if profile_type == "player"
      #puts sorted_profiles[0]["bio"]
      #puts sorted_profiles[0]["user_id"]
      result = []
      sorted_profiles.each do |pro|
        #puts pro["bio"]
        #puts pro["user_id"]
        result << PlayerProfile.find(pro["id"])
        #puts result.count
      end
      return result
    else # profile_type == "dm"
      #puts sorted_profiles[0]["user_id"]
      #puts sorted_profiles[0]["bio"]
      result = []
      sorted_profiles.each do |pro|
        #puts pro["bio"]
        #puts pro["user_id"]
        result << DmProfile.find(pro["id"])
        #puts result.count
      end
      return result
    end
  end
end
