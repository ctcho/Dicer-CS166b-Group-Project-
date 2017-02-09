json.extract! player_bio, :id, :bio, :exp_level, :ruleset1, :ruleset2, :ruleset3, :ruleset4, :created_at, :updated_at
json.url player_bio_url(player_bio, format: :json)