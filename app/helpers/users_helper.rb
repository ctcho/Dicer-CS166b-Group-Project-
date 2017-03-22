module UsersHelper

  #Takes the integer of experience level and converts it to its corresponding string
  def translate_experience_level(profile)
    exp = profile.experience_level
    case exp
    when 0
      "New player (no experience)"
    when 1
      "Beginner (0-1 years of play)"
    when 2
      "Novice (1-2 years of play)"
    when 3
      "Experienced (2-5 years of play)"
    else
      "Veteran (More than 5 years of play)"
    end
  end

  #Takes the integer of online play willingness and converts it to its corresponding string
  def translate_online_play(profile)
    bool = profile.online_play
    case bool
    when 0
      "Not willing to play online"
    else
      "Willing to play online"
    end
  end

  def find_distance(user1, user2)
    if(!!user2)
      distance = user1.distance_from(user2)
      "%.1f miles away" % distance
    else
      "Error: Session not found"
    end
  end

  def user_settings_path user
    "/user/#{user.id}/settings"
  end

end
