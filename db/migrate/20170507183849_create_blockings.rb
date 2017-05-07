class CreateBlockings < ActiveRecord::Migration[5.0]
  def change
    create_table :blockings do |t|
      t.integer :user_id
      t.integer :blocked_id

      t.timestamps
    end
  end
end
