require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    User.destroy_all
    @user = User.create(email: "mystring@example.com", password: "strongpass", password_confirmation: "strongpass", username: "unique_names", age: 18, address: "02453")
    @user2  = User.create(email: "myotherstring@example.com", password: "strongpass", password_confirmation: "strongpass", username: "another_unique_name", address: "02453")
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
    assert_redirected_to new_user_dm_profiles_url(User.last, tutorial:"")
  end

#  test "should show user" do
#    get user_url(@user)
#    assert_response :success
#  end


  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_redirected_to login_path
  end

  test "should redirect edit when logged in as the wrong user" do
    log_in_as(@user2, 'strongpass', 0)
    get edit_user_path(@user)
    assert_redirected_to '/unauthorized'
  end

  test "should redirect update when logged in as the wrong user" do
    log_in_as(@user2, 'strongpass', 0)
    patch user_path(@user), params: { user: { username: @user.username,
                                              email: @user.email } }
    assert_redirected_to '/unauthorized'

  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user:  {username: "NewUserName", email: @user.email}}
    assert_redirected_to login_path

  end
  #test "should update user" do
  #  patch user_url(@user), params: { user: { password: @user.password, password_confirmation: @user.password, age: @user.age, email: @user.email, last_active: @user.last_active, profile_pic_path: @user.profile_pic_path, username: @user.username, address: "48183"} }
  #  assert_redirected_to user_url(@user)
  #end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
