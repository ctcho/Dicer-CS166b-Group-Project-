class RemoveMaxDistanceFromPlayerProfiles < ActiveRecord::Migration[5.0]
  def change
    remove_column :player_profiles, :max_distance, :integer
  end
end
