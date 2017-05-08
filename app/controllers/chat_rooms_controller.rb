class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: [:show, :remove_user]
  before_action :logged_in_user
  before_action :correct_user, only: [:show, :remove_user]
  before_action :is_owner, only: [:remove_user, :add_user]

  def create
    @chat_room = ChatRoom.new(chat_room_params)
    if @chat_room.save
      puts "yay!"
      ChatRoomsUser.create(chat_room: @chat_room, user: current_user)
      params[:users].each do |user|
        ChatRoomsUser.create(chat_room: @chat_room, user_id: user)
      end
      redirect_to chat_room_path(@chat_room), notice: 'Chat successfully created'
    else
      render :new
    end
  end

  def new
    @user = current_user
    @chat_room = ChatRoom.new
    @friends = @user.friends
  end

  def index
    @chat_rooms = User.find_by(id: params[:format]).chat_rooms
  end

  def show
    user = current_user
    @messages = @chat_room.messages.order(:created_at)
    @chat_rooms = user.chat_rooms#ChatRoom.all; # FOR CSS PURPOSES, REPLACE WITH ALL CHATS ACTIVE FOR THE ACCESSING USER
    @participating_users = @chat_room.users#User.all; # FOR CSS PURPOSES, REPLACE WITH ALL USERS ACTIVE IN THE CURENT CHAT
    ChatRoomsUser.where("user_id = ?", current_user.id).find_by(chat_room_id: params[:id])
                 .update_attributes(last_viewed: Time.now)

  end

  def remove_user
    user = current_user
    chat_rooms_user = ChatRoomsUser.find_by(chat_room: @chat_room, user: user)
    chat_rooms_user.destroy
    respond_to do |format|
      format.html { redirect_to users_path(user), notice: 'Successfully left chat' }
      format.json { head :no_content }
    end
  end

  def add_user

  end



  private

  def correct_user
    authorized_users = @chat_room.users
    redirect_to('/unauthorized') if authorized_users.merge(User.where(id: current_user.id)).empty?
  end

  def is_owner
    current_user == @chat_room.owner
  end

  def chat_room_params
    {owner: User.find(1), name: params[:name], avatar: params[:avatar]}
  end

    def set_chat_room
      @chat_room = ChatRoom.find(params[:id])
    end

    def logged_in_user
      unless logged_in?
        store_location
        redirect_to login_url, notice: "Please Log In"
      end
    end
end
