module SearchPagesHelper
include UsersHelper
#include SessionsHelper

  def has_valid_users(search_results)
    results = search_results.count
    search_results.each do |user|
      if user.nil? || user.user == current_user || !within_distance(current_user, user.user)
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
      if limit > 0 && !profile.nil? && profile.user != current_user && profile.user != viewed_user && within_distance(current_user, profile.user) && (profile.user.age - viewed_user.age).abs <= 3
        set << profile
        limit = limit - 1
      end
    end
    return set
  end

end
