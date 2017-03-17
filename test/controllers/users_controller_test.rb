require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    User.destroy_all
    @user = User.create(email: "mystring@example.com", password: "strongpass", password_confirmation: "strongpass", username: "unique_names", age: 18, address: "02453")
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
    post users_url, params: { user: { email: "Unique@email.com", password: "strongpass", password_confirmation: "strongpass", username: "Unique_Username", address: "02453"} }
    end
    assert_redirected_to new_user_player_profiles_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should not get edit if not logged in" do
    get edit_user_url(@user)
    assert_redirected_to home_pages_unauthorized_url
  end

  test "should update user" do
    patch user_url(@user), params: { user: { password: @user.password, password_confirmation: @user.password, age: @user.age, email: @user.email, last_active: @user.last_active, profile_pic_path: @user.profile_pic_path, username: @user.username, address: "48183"} }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
