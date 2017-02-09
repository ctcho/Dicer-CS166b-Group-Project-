class CreateDmBios < ActiveRecord::Migration[5.0]
  def change
    create_table :dm_bios do |t|
      t.text :bio
      t.integer :exp_level
      t.boolean :ruleset1
      t.boolean :ruleset2
      t.boolean :ruleset3
      t.boolean :ruleset4

      t.timestamps
    end
  end
end
