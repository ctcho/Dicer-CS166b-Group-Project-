require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @user2 = users(:two)
    @p1 = player_profiles(:one)
    @p2 = player_profiles(:two)
    @user.player_profile = @p1
    @user2.player_profile = @p2
  end

  def invalid_login
    get login_path
    post login_path, params: {session: {email: "", password: "" } }
  end

  def valid_login
    get login_path
    post login_path, params: {session: {email: @user.email, password: 'password'} }
  end

  test "invalid credentials returns to login page" do
    invalid_login
    assert_template 'sessions/new'
  end

  test "valid login redirects to user user#show" do
    valid_login
    assert_redirected_to @user
  end

  test "valid login redirects to users/show template" do
    valid_login
    follow_redirect!
    assert_template 'users/show'
  end

  test "valid log in correctly alters layout" do
    valid_login
    follow_redirect!
    assert_select"a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "can log out a logged in user" do
    valid_login
    delete logout_path
    assert_not session[:user_id]
  end

  test "user redirected to root after logging out" do
    valid_login
    follow_redirect!
    delete logout_path
    assert_redirected_to root_url
  end

  test "login with valid information followed by logout" do
    valid_login
    delete logout_path
    # Simulate a user clicking logout in a second window.
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with remembering" do
    log_in_as(@user, 'password', 1)
    assert_not_empty cookies['remember_token']
  end

  test "login without remembering" do
    # Log in to set the cookie.
    log_in_as(@user, 'password', 1)
    # Log in again adn verify that the cookie is deleted
    log_in_as(@user, 'password', 0)
    assert_empty cookies['remember_token']
  end



end
