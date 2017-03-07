json.extract! user, :id, :username, :string, :email, :password_digest, :profile_pic_path, :player_profile_id, :dm_profile_id, :age, :last_active, :created_at, :updated_at
json.url user_url(user, format: :json)
