class CreatePlayerProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :player_profiles do |t|
      t.integer :user_id
      t.text :bio
      t.integer :experience_level
      t.integer :online_play
      t.integer :homebrew
      t.integer :original_ruleset
      t.integer :advanced_ruleset
      t.integer :pathfinder
      t.integer :third
      t.integer :three_point_five
      t.integer :fourth
      t.integer :fifth
      t.integer :original_campaign
      t.integer :module

      t.timestamps
    end
  end
end
