class CreateCharacterSheets < ActiveRecord::Migration[5.0]
  def change
    create_table :character_sheets do |t|
      t.integer :player_profile_id
      t.string :file_path

      t.timestamps
    end
  end
end
