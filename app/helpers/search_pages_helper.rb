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

end
