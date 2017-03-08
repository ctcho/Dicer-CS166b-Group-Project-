class AddLngToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :lng, :float
  end
end
