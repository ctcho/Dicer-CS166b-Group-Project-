json.extract! character_sheet, :id, :player_profile_id, :file_path, :created_at, :updated_at
json.url character_sheet_url(character_sheet, format: :json)
