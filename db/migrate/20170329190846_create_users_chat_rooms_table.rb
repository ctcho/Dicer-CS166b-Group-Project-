class CreateUsersChatRoomsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_rooms_users do |t|
      t.integer :user_id
      t.integer :chat_room_id
    end
  end
end
