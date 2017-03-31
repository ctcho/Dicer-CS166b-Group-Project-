module SearchPagesHelper

  def search_exec(parameters)
    ruleset = Integer(parameters[:ruleset1])
    if Integer(parameters[:profile_type]) == 0 #Search the player database
      if Integer(parameters[:campaign_type]) == 1 #Search for original campaigns
        case ruleset #Since I am currently only searching for most preferred ruleset
        when 1 #Home brew rulesest
          PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
          homebrew: 1, online_play: Integer(parameters[:online_play]), original_campaign: 1)
        when 2 #Original ruleset
          PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
          original_ruleset: 1, online_play: Integer(parameters[:online_play]), original_campaign: 1)
        when 3 #Advanced Ruleset
          PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
          advanced_ruleset: 1, online_play: Integer(parameters[:online_play]), original_campaign: 1)
        when 4 #Pathfinder ruleset
          PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
          pathfinder: 1, online_play: Integer(parameters[:online_play]), original_campaign: 1)
        when 5 #Third edition ruleset
          PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
          third: 1, online_play: Integer(parameters[:online_play]), original_campaign: 1)
        when 6 #Three.five ruleset
          PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
          three_point_five: 1, online_play: Integer(parameters[:online_play]), original_campaign: 1)
        when 7 #Fourth edition ruleset
          PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
          fourth: 1, online_play: Integer(parameters[:online_play]), original_campaign: 1)
        else #Fifth edition ruleset
          PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
          fifth: 1, online_play: Integer(parameters[:online_play]), original_campaign: 1)
        end

      else #Search for module-based campaigns
        case ruleset #Since I am currently only searching for most preferred ruleset
        when 1 #Home brew rulesest
          PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
          homebrew: 1, online_play: Integer(parameters[:online_play]), module: 1)
        when 2 #Original ruleset
          PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
          original_ruleset: 1, online_play: Integer(parameters[:online_play]), module: 1)
        when 3 #Advanced Ruleset
          PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
          advanced_ruleset: 1, online_play: Integer(parameters[:online_play]), module: 1)
        when 4 #Pathfinder ruleset
          PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
          pathfinder: 1, online_play: Integer(parameters[:online_play]), module: 1)
        when 5 #Third edition ruleset
          PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
          third: 1, online_play: Integer(parameters[:online_play]), module: 1)
        when 6 #Three.five ruleset
          PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
          three_point_five: 1, online_play: Integer(parameters[:online_play]), module: 1)
        when 7 #Fourth edition ruleset
          PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
          fourth: 1, online_play: Integer(parameters[:online_play]), module: 1)
        else #Fifth edition ruleset
          PlayerProfile.where(experience_level: Integer(parameters[:experience_level]),
          fifth: 1, online_play: Integer(parameters[:online_play]), module: 1)
        end
      end


    else #Searching for DM's
      if Integer(parameters[:campaign_type]) == 1 #Search for original campaigns
        case ruleset #Since I am currently only searching for most preferred ruleset
        when 1 #Home brew rulesest
          DmProfile.where(experience_level: Integer(parameters[:experience_level]),
          homebrew: 1, online_play: Integer(parameters[:online_play]), original_campaign: 1)
        when 2 #Original ruleset
          DmProfile.where(experience_level: Integer(parameters[:experience_level]),
          original_ruleset: 1, online_play: Integer(parameters[:online_play]), original_campaign: 1)
        when 3 #Advanced Ruleset
          DmProfile.where(experience_level: Integer(parameters[:experience_level]),
          advanced_ruleset: 1, online_play: Integer(parameters[:online_play]), original_campaign: 1)
        when 4 #Pathfinder ruleset
          DmProfile.where(experience_level: Integer(parameters[:experience_level]),
          pathfinder: 1, online_play: Integer(parameters[:online_play]), original_campaign: 1)
        when 5 #Third edition ruleset
          DmProfile.where(experience_level: Integer(parameters[:experience_level]),
          third: 1, online_play: Integer(parameters[:online_play]), original_campaign: 1)
        when 6 #Three.five ruleset
          DmProfile.where(experience_level: Integer(parameters[:experience_level]),
          three_point_five: 1, online_play: Integer(parameters[:online_play]), original_campaign: 1)
        when 7 #Fourth edition ruleset
          DmProfile.where(experience_level: Integer(parameters[:experience_level]),
          fourth: 1, online_play: Integer(parameters[:online_play]), original_campaign: 1)
        else #Fifth edition ruleset
          DmProfile.where(experience_level: Integer(parameters[:experience_level]),
          fifth: 1, online_play: Integer(parameters[:online_play]), original_campaign: 1)
        end

      else #Search for module-based campaigns
        case ruleset #Since I am currently only searching for most preferred ruleset
        when 1 #Home brew rulesest
          DmProfile.where(experience_level: Integer(parameters[:experience_level]),
          homebrew: 1, online_play: Integer(parameters[:online_play]), module: 1)
        when 2 #Original ruleset
          DmProfile.where(experience_level: Integer(parameters[:experience_level]),
          original_ruleset: 1, online_play: Integer(parameters[:online_play]), module: 1)
        when 3 #Advanced Ruleset
          DmProfile.where(experience_level: Integer(parameters[:experience_level]),
          advanced_ruleset: 1, online_play: Integer(parameters[:online_play]), module: 1)
        when 4 #Pathfinder ruleset
          DmProfile.where(experience_level: Integer(parameters[:experience_level]),
          pathfinder: 1, online_play: Integer(parameters[:online_play]), module: 1)
        when 5 #Third edition ruleset
          DmProfile.where(experience_level: Integer(parameters[:experience_level]),
          third: 1, online_play: Integer(parameters[:online_play]), module: 1)
        when 6 #Three.five ruleset
          DmProfile.where(experience_level: Integer(parameters[:experience_level]),
          three_point_five: 1, online_play: Integer(parameters[:online_play]), module: 1)
        when 7 #Fourth edition ruleset
          DmProfile.where(experience_level: Integer(parameters[:experience_level]),
          fourth: 1, online_play: Integer(parameters[:online_play]), module: 1)
        else #Fifth edition ruleset
          DmProfile.where(experience_level: Integer(parameters[:experience_level]),
          fifth: 1, online_play: Integer(parameters[:online_play]), module: 1)
        end
      end  #End of else for campaign type
    end #End of else for profile types
  end #End of search method

end
