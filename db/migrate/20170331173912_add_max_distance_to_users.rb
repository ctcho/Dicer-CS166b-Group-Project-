class AddMaxDistanceToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :max_distance, :integer
  end
end
