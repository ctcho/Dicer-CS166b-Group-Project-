class AddUserIdToDmProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :dm_profiles, :user_id, :integer
  end
end
