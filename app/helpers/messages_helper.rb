module MessagesHelper

  def exists_chatroom(user1, user2)
    room = ChatRoom.joins(:chat_rooms_users)
              .where(chat_rooms_users: {user_id: [user1] } )
              .where(chat_rooms_users: {chat_room_id: User.find(user2).chat_room_ids})
    room.first
  end
end
