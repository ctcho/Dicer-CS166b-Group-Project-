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
      if limit > 0 && profile.user != current_user && profile.user != viewed_user && within_distance(current_user, profile.user) && (profile.user.age - viewed_user.age).abs <= 3
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
end
