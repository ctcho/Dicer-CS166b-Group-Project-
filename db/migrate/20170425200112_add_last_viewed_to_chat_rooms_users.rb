class AddLastViewedToChatRoomsUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :chat_rooms_users, :last_viewed, :datetime
  end
end
