class AddChatRoomIdForeignKeyToMessages < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :chat_rooms, :messages, column: :chat_room_id
  end
end
