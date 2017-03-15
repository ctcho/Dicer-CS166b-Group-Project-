class RemoveDmProfileIdFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :dm_profile_id, :integer
  end
end
