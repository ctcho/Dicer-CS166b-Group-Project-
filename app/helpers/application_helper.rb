module ApplicationHelper

  def online_status(user)
    dot = content_tag :span, "&#11044;".html_safe,
                class: "user-#{user.id} online_status #{'online' if user.online?}"
  end

  #Function that sends back different versions of "Chats" depending on
  #if user has new messages or not
  #It has a nested for loop- pretty bad
  def num_unread()
    all_chats = current_user.chat_rooms
    num_unseen = 0
    all_chats.each do |chat|
      msgs = chat.messages.sort_by {|m| m.created_at}.reverse
      cru = ChatRoomsUser.where("chat_room_id = ?", chat.id)
                         .where("user_id = ?", current_user.id)[0] #should be only one of these
      l_viewed = cru.last_viewed
      msgs.each do |msg|
        if l_viewed != nil #user has looked at a chat before
          if msg.created_at > l_viewed
            num_unseen += 1
          else
            break
          end
        else
          num_unseen += 1
        end
      end
    end
    num_unseen
  end

  #chat room that current_user has most recently posted in, or
  #new chat room if current_user has none
  def most_recent
    if current_user.messages.last.nil?
      new_chat_room_path
    else
      chat_room_path(current_user.messages.last.chat_room_id)
    end
  end
end
