class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.float :lat
      t.float :lng
      t.string :remember_digest
      t.float :max_distance

      t.integer :age
      t.string :address
      t.datetime :last_active
      t.timestamps

      t.attachment :avatar
      t.boolean :admin, default: false
    end
  end
end
