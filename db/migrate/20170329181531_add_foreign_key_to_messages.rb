class AddForeignKeyToMessages < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :users, :messages, column: :user_id
  end
end
