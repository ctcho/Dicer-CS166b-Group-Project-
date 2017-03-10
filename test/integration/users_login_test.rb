require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
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

  test "invalid credentials flashes an error on the login page" do
    invalid_login
    assert_not flash.empty?
  end

  test "remove flash when user leaves page" do
    invalid_login
    get root_path
    assert flash.empty?
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


end
