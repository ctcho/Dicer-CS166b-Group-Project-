json.extract! player_profile, :id, :bio, :exp_level, :ruleset1, :ruleset2, :ruleset3, :ruleset4, :created_at, :updated_at, :user_id
json.url player_profile_url(player_profile, format: :json)
