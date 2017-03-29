require 'test_helper'

class UsersEditTest <ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "gets the edit page when user is logged in" do
    log_in_as(@user, 'password', 1)
    get edit_user_path(@user)
    assert_template 'users/edit'
  end

  test "returns to edit page when unsuccessful edit" do
    log_in_as(@user, 'password', 1)
    get edit_user_path(@user)
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password: "foo",
                                              password_confirmation: "bar" } }
    assert_template 'users/edit'
  end

  test "correctly routes after a successful edit" do
    log_in_as(@user, 'password', 1)
    username = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { username:  username,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_redirected_to edit_user_path(@user)
    @user.reload
    assert_equal username, @user.username
    assert_equal email, @user.email
  end

end
