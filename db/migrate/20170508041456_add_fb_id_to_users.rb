class AddFbIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :fb_id, :bigint, default: 0
  end
end
