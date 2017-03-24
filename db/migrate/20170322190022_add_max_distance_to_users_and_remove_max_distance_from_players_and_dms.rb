class AddMaxDistanceToUsersAndRemoveMaxDistanceFromPlayersAndDms < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :max_distance, :float
    remove_column :player_profiles, :max_distance, :float
    remove_column :dm_profiles, :max_distance, :float
  end
end
