class AddOwnerToChatRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :chat_rooms, :owner_id, :integer
  end
end
