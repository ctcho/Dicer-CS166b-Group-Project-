json.extract! dm_profile, :id, :user_id, :bio, :experience_level, :online_play, :homebrew, :original_ruleset, :advanced_ruleset, :pathfinder, :third, :three_point_five, :fourth, :fifth, :original_campaign, :module, :created_at, :updated_at
json.url user_dm_profiles_url(dm_profile, format: :json)
