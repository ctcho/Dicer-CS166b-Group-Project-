class MessagesController < ApplicationController

  before_action :logged_in_user

  def create
    room = nil
    sender = current_user
    if params[:chat_room_id]
      room = ChatRoom.find(params[:chat_room_id])
    else
      shared_chats = ChatRoom.joins(:chat_rooms_users).where("chat_rooms_users.user_id LIKE ? OR chat_rooms_users.user_id LIKE ?", sender.id, params[:user_id]).merge(ChatRoom.group('user_id').having("count('user.id') = 2"))
      if shared_chats.empty?
        room = ChatRoom.create(name: "private_chat_#{sender.id}_#{params[:user_id]}")
        ChatRoomsUser.create(chat_room_id: room.id, user_id: sender.id)
        ChatRoomsUser.create(chat_room_id: room.id, user_id: params[:user_id] )
      else
        room = shared_chats[0]
      end
    end
    if room
      room.messages.create(content: params[:message], user_id: sender.id)
      #temporary, figure out where we should redirect to.
      redirect_to chat_room_url(room)
    else
      #temporary, render an error password_digest
      render 'error'
    end
  end

  def new

    @message = Message.new
  end

  private
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please Log In"
        redirect_to login_url, notice: "Please Log In"
      end
    end

end
