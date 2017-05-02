class CreateChatRoomsUsersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_rooms_users do |t|
      t.integer :chat_room_id
      t.integer :user_id
      t.datetime :last_viewed
    end
  end
end
