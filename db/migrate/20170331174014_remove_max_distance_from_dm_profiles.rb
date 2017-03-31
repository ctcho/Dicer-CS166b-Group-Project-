class RemoveMaxDistanceFromDmProfiles < ActiveRecord::Migration[5.0]
  def change
    remove_column :dm_profiles, :max_distance, :integer
  end
end
