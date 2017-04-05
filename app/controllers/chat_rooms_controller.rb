class ChatRoomsController < ApplicationController
  def create

  end

  def new
  end


  def show
    @room = ChatRoom.find(params[:id])
    @messages = @room.messages.order(:created_at)
  end
end
