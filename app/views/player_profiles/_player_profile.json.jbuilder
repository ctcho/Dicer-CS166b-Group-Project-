json.extract! player_profile, :id, :user_id, :bio, :experience_level, :online_play, :homebrew, :original_ruleset, :advanced_ruleset, :pathfinder, :third, :three_point_five, :fourth, :fifth, :original_campaign, :module, :created_at, :updated_at
json.url user_player_profiles_url(player_profile, format: :json)
