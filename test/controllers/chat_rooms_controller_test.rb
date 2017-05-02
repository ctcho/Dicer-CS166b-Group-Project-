require 'test_helper'

class ChatRoomsControllerTest <ActionDispatch::IntegrationTest

  setup do
    @chat_room = ChatRoom.new(name: "test room")
    @user1 = users(:one)
    @user2 = users(:two)
    @user3 = users(:user_3)
    @chat_room.users << @user1 << @user2
    @chat_room.save
  end

  test "should get show if user is authorized" do
    log_in_as(@user1, 'password', 0)
    get chat_room_path(@chat_room)
    assert_response :success
  end

  test "should redirect correctly if user is not authorized" do
    log_in_as(@user3, 'strongpass3', 0)
    get chat_room_path(@chat_room)
    assert_redirected_to unauthorized_path

  end

  test "should redirect correctly if user is not logged in" do
    get chat_room_path(@chat_room)
    assert_redirected_to login_path
  end

  test "user can remove self from chat" do
    log_in_as(@user1, 'password', 0)
    delete leave_chat_path(@chat_room)
    assert !ChatRoomsUser.where(user: @user1, chat_room: @chatroom).exists?
  end

  test "user cannot remove another user from chat" do

  end


end
