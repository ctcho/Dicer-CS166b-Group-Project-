module UsersHelper


  #Takes the integer of experience level and converts it to its corresponding string
  def translate_experience_level(exp)
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

  def find_distance(user1, user2) # returns a string specifying distance between two players
    if(!!user2)
      distance = user1.distance_from(user2)
      "%.1f miles away" % distance
    else
      "Error: Session not found"
    end
  end

  def num_distance(user1, user2) # returns the numerical distance between two players
    if (!!user1 && !!user2)
      distance = user1.distance_from(user2)
      distance
    else
      nil
    end
  end


  def get_ruleset_strings(profile) # creates a string array of all the rulesets the user plays
    rulesets = Array.new
    if(profile.original_ruleset > 0)
      rulesets << "Original Dungeons and Dragons"
    end
    if(profile.advanced_ruleset > 0)
      rulesets << "Advanced Dungeons and Dragons"
    end
    if(profile.third > 0)
      rulesets << "Third Edition"
    end
    if(profile.three_point_five > 0)
      rulesets << "3.5 Edition"
    end
    if(profile.fourth > 0)
      rulesets << "Fourth Edition"
    end
    if(profile.fifth > 0)
      rulesets << "Fifth Edition"
    end
    if(profile.pathfinder > 0)
      rulesets << "Pathfinder"
    end
    rulesets
  end

  def within_distance(user1, user2) # returns true if the users are within visiting distance
    #byebug
    distance = num_distance(user1, user2)
    if(!!distance)
      user1.max_distance > distance && user2.max_distance > distance
    else
      false
    end
  end

  def user_settings_path user
    "/user/#{user.id}/settings"
  end

  def ruleset_preview(profile) # samples their rulesets and returns a random 3, specifying if there are any more
    rulesets = get_ruleset_strings(profile)
    html = ""
    length = rulesets.length
    if(length <= 3)
      html << rulesets.join("<br>")
    else
      html << rulesets.sample(3).join("<br>")
      html << "<br> and #{length-3} more..."
    end
    html.html_safe
  end

  def get_similar_profiles(user)
    similar_profiles = []
    if user.dm_profile.nil?
      similar_players = recommend_set(User.recommender(user.player_profile, "player"), user)
      similar_dms = recommend_set(User.recommender(user.player_profile, "dm"), user)
    elsif user.player_profile.nil?
      similar_players = recommend_set(User.recommender(user.dm_profile, "player"), user)
      similar_dms = recommend_set(User.recommender(user.dm_profile, "dm"), user)
    else #user has both
      similar_players = recommend_set(User.recommender(user.player_profile, "player"), user)
      similar_dms = recommend_set(User.recommender(user.dm_profile, "dm"), user)
    end
    if !similar_players.empty?
      count = 0
      similar_players.each do |player|
        #byebug
        if count < 2
          similar_profiles << player
        end
        count = count + 1
      end
    end
    if !similar_dms.empty?
      count = 0
      similar_dms.each do |dm|
        #byebug
        if count < 2
          similar_profiles << dm
        end
        count = count + 1
      end
    end
    return similar_profiles
  end

  def profile_link(profile) # returns either a dm profile link or player profile link depending on player profile type
    if(profile.nil?)
      nil
    else
      user = User.find(profile.user_id)
      if(profile.is_a?(DmProfile))
        return user_dm_profiles_path(user)
      else
        return user_player_profiles_path(user)
      end
    end
  end

  def friends?(user) # returns true if the current user and input user are friends
    return false
  end

end
