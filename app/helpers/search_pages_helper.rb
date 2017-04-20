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
    #counter = 0
    sorted_profiles = unsorted_profiles.as_json
    sorted_profiles.each do |profile|
      profile["check_sum"] = 0
      #keys = search_filter.keys
      search_filter.each do |spec|
        if profile.include?(spec[0].to_s)
          if profile[spec[0].to_s] == spec[1]
            profile["check_sum"] = profile["check_sum"] + 1
          end
        end
      end
      #puts "#{profile["check_sum"]}"
    end
    sorted_profiles = sorted_profiles.sort { |a, b| b["check_sum"] <=> a["check_sum"] }
    result = Hash.new
    sorted_profiles.each do |pro|
      #result[]
    end
    return
  end
end
