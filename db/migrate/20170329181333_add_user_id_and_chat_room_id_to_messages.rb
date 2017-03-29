class AddUserIdAndChatRoomIdToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :user_id, :integer
    add_column :messages, :chat_room_id, :integer
  end
end
