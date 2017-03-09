class RemovePlayerProfileIdFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :player_profile_id, :integer
  end
end
