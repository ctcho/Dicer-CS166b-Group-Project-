class MessagesController < ApplicationController
  include MessagesHelper

  before_action :logged_in_user

  def create
    if params[:chat_room_id]
      @chat_room = ChatRoom.find(params[:chat_room_id])
    else
      @receiver = User.find_by(id: params[:user_id])
      @chat_room = exists_chatroom current_user, @receiver
      if @chat_room == nil
        @chat_room = ChatRoom.new(name: "#{current_user.username} and #{@receiver.username}")
        @chat_room.users << @receiver
        @chat_room.users << current_user
        @chat_room.save
      end
    end
    #problem: if we resend the post request, a duplicate message ends up being
    #created. But it is a problem when I keep resending the request to look at debug
    #information. Would this happen in real life if I prohibit the send button from being clicked
    #twice?
    byebug
    current_user.messages.build(content: params[:message][:content], chat_room_id: @chat_room.id)
    current_user.save
    @messages = @chat_room.messages
    redirect_to chat_room_path(@chat_room)
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
