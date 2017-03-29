require 'test_helper'

class DmProfilesEditTest <ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @dm_profile = @user.dm_profile = dm_profiles(:one)
    @user.save
  end

  test "gets the edit page when the user is logged in" do
    log_in_as(@user, 'password', 1)
    get edit_user_dm_profiles_path(@user)
    assert_template 'dm_profiles/edit'
  end

  test "returns to edit page when unsuccessful edit" do
    log_in_as(@user, 'password', 1)
    get edit_user_dm_profiles_path(@user)
    patch user_dm_profiles_path, params: {dm_profile: {
      bio: nil
      }}
    assert_template 'dm_profiles/edit'
  end

  test "correctly routes after a successful edit" do
    log_in_as(@user, 'password', 1)
    bio = "New bio"
    get edit_user_dm_profiles_path(@user)
    patch user_dm_profiles_path, params: { dm_profile: {experience_level: 3,
      bio: bio
      }}
      assert_redirected_to user_dm_profiles_path(@user. @player_profile)
      @dm_profile.reload
      assert_equal bio, @dm_profile.bio
  end

end
