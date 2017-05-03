class MessagesController < ApplicationController
  include MessagesHelper

  before_action :logged_in_user

  #right now this is more or less functional for 1-on-1 chats. Next step: groupd
  #chats
  def create
    @receiver = User.find_by(id: params[:user_id]) ||
                User.find_by(id: (ChatRoom.find_by(id: params[:chat_room_id]).users - [current_user]).first.id)
    @chat_room = exists_chatroom current_user, @receiver
    if @chat_room == nil
      @chat_room = ChatRoom.new(name: "#{current_user.username} and #{@receiver.username}")
      @chat_room.users << @receiver
      @chat_room.users << current_user
      @chat_room.save
    end
      #it might not be true that a user looks at a chatroom when they send a message
      ChatRoomsUser.where("user_id = ?", current_user.id).find_by(chat_room_id: @chat_room.id)
                   .update_attributes(last_viewed: Time.now)
    #problem: if we resend the post request, a duplicate message ends up being
    #created. But it is a problem when I keep resending the request to look at debug
    #information. Would this happen in real life if I prohibit the send button from being clicked
    #twice?
    message = current_user.messages.build(content: params[:message][:content], chat_room_id: @chat_room.id)
    if message.save
      ActionCable.server.broadcast "chat_rooms_#{@chat_room.id}_channel", content: message.content, username: message.user.username
    end
    @messages = @chat_room.messages
    redirect_to chat_room_path(@chat_room)
  end

  def new
    @message = Message.new
  end

  def show
    @messages = User.find(params[:user_id]).messages
  end

  def edit

  end

  private
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please Log In"
        redirect_to login_url, notice: "Please Log In"
      end
    end

    def get_messages
      @messages = Message.for_display
      @message = current_user.messages.build
    end

    def message_params
      params.require(:message).permit(:content)
    end

end
