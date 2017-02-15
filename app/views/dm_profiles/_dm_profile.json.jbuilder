json.extract! dm_profile, :id, :bio, :exp_level, :ruleset1, :ruleset2, :ruleset3, :ruleset4, :created_at, :updated_at
json.url dm_profile_url(dm_profile, format: :json)
