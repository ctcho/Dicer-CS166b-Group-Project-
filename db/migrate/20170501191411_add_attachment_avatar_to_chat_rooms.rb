class AddAttachmentAvatarToChatRooms < ActiveRecord::Migration
  def self.up
    change_table :chat_rooms do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :chat_rooms, :avatar
  end
end
