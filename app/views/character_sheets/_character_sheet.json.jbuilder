json.extract! character_sheet, :id, :user_id, :filename, :bio, :created_at, :updated_at
json.url character_sheet_url(character_sheet, format: :json)