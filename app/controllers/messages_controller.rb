class MessagesController < ApplicationController

  # consider whether this should be merged with the chatrooms controller?
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
    if params[:message][:content].starts_with? "/"
      roll = parse_command params[:message][:content]
        message = current_user.messages.build(content: roll, chat_room_id: @chat_room.id)
    else
      message = current_user.messages.build(content: params[:message][:content], chat_room_id: @chat_room.id)
    end
    if message.save
      ActionCable.server.broadcast "chat_rooms_#{@chat_room.id}_channel", content: message.content, username: message.user.username, avatar_path: message.user.avatar.url(:smallerthumb)
    else
      @messages = @chat_room.messages
      redirect_to chat_room_path(@chat_room)
    end
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

    def parse_command command
      valid_dice =[2, 4, 6, 10, 8, 20, 100]
      # check that command is recognized/what it is
      if command.starts_with?("/roll")
      #check command parameters, else error
        parameters = command[/([0-9]*)d([0-9]*)/]
        if parameters
          numbers = parameters.split("d").map{ |x| x.to_i }
          string = "#{current_user.username} has rolled #{parameters}: "
          sum = 0
          if valid_dice.include?(numbers[1])
            numbers[0].times do
              num = rand(numbers[1]) + 1
              string +=  num.to_s + " "
              sum += num
            end
            return string + ", sum: #{sum}"
          end
          return "#{current_user.username} has attempted an illegal diceroll: #{parameters}. Please use the following format: /roll <number of dice>d<die type>. Dice may have 2, 4, 6, 8, 10, 20, or 100 sides"
        end
      end
      return nil
    end

    def get_messages
      @messages = Message.for_display
      @message = current_user.messages.build
    end

    def message_params
      params.require(:message).permit(:content)
    end

end
