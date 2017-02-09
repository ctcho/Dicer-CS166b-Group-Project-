class CreatePlayerBios < ActiveRecord::Migration[5.0]
  def change
    create_table :player_bios do |t|
      t.text :bio
      t.string :exp_level
      t.boolean :ruleset1
      t.boolean :ruleset2
      t.boolean :ruleset3
      t.boolean :ruleset4

      t.timestamps
    end
  end
end
