require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(email: "mystring@example.com", password: "strongpass", password_confirmation: "strongpass", username: "unique_names", age: 18)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { age: @user.age, dm_profile_id: @user.dm_profile_id, email: "Unique@email.com", last_active: @user.last_active, password: "strongpass", password_confirmation: "strongpass", player_profile_id: @user.player_profile_id, profile_pic_path: @user.profile_pic_path, username: "Unique_Username" } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { password: @user.password, password_confirmation: @user.password, age: @user.age, email: @user.email, last_active: @user.last_active, profile_pic_path: @user.profile_pic_path, string: @user.string, username: @user.username } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
