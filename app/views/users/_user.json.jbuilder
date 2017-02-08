json.extract! user, :id, :email, :password_hash, :username, :zipcode, :profile_pic, :player_id, :dm_id, :created_at, :updated_at
json.url user_url(user, format: :json)