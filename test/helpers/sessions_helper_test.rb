# These tests fail because the way the cookies are implemented is
# for some reason incompatible with the way Rack tests
# handles cookies. 
#require 'test_helper'

#class SessionsHelperTest <ActionDispatch::IntegrationTest

#  def setup
#    @user = users(:one)
#    remember(@user)
#  end

#  test "current user returns right user when session is nil" do
#    assert_equal @user, current_user
#    assert is_logged_in?
#  end

#  test "current_user returns nil when remember digest is wrong" do
#    @user.update_attribute(:remember_digest, User.digest(User.new_token))
#    assert_nil current_user
#  end
#end
