class CreateCharacterSheets < ActiveRecord::Migration[5.0]
  def change
    create_table :character_sheets do |t|
      t.integer :user_id
      t.string :filename
      t.text :bio

      t.timestamps
    end
  end
end
