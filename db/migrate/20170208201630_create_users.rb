class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_hash
      t.string :username
      t.integer :zipcode
      t.string :profile_pic
      t.integer :player_id
      t.integer :dm_id

      t.timestamps
    end
  end
end
