module MessagesHelper

  def exists_chatroom(user1, user2)
    room = ChatRoom.joins(:chat_rooms_users)
              .where(chat_rooms_users: {user_id: [user1] } )
              .where(chat_rooms_users: {chat_room_id: User.find(user2).chat_room_ids})
    room.first
  end

  def render_message data
    user = data.username
    avatar_html = "<div class='message-user'>\n<img class='message-avatar' src=#{user.avatar.url(:smallerthumb)}/>\n</div>\n"
    message_html = "<div class='message'>\n<div class='message-content-black-border-text>\n'#{data.content}\n</div>\n</div>\n"
    html = "<div class='message-container'>"
    if user = current_user
      html += message_html + avatar_html
    else
      html += avatar_html + message_html
    end
    html += "</div>\n"
    return html.html_safe
  end

      #<div class="message">
      #  <div class="message-content black-border-text">
      #     <%= message.content %>
      #  </div>
      #</div>
      #<% if current_user.id = message.user.id %>
      #  <div class="message-user">
      #      <%= link_to image_tag(message.user.avatar.url(:smallerthumb), class: "message-avatar"), user_path(message.user.id) %>
      #  </div>
      #<%end%>
    #</div>"
end
