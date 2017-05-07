module ApplicationHelper

  def online_status(user)
    dot = content_tag :span, "&#11044;".html_safe,
                class: "user-#{user.id} online_status #{'online' if user.online?}"
  end
  #Function that sends back different versions of "Chats" depending on
  #if user has new messages or not
  #It has a nested for loop- fuck me
  def chats_helper
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
    "Chats-#{num_unseen}"
  end
end
