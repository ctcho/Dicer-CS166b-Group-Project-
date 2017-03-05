class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :profile_pic_path
      t.integer :player_profile_id
      t.integer :dm_profile_id
      t.integer :age
      t.string :address
      t.datetime :last_active

      t.timestamps
    end
  end
end
