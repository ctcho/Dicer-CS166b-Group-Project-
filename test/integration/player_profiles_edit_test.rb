require 'test_helper'

class PlayerProfilesEditTest <ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @player_profile = @user.player_profile = player_profiles(:one)
    @user.save
  end

  test "gets the edit page when the user is logged in" do
    get edit_user_player_profiles_path(@user)
    log_in_as(@user, 'password', 1)
    assert_redirected_to edit_user_player_profiles_path(@user)
  end

  test "returns to edit page when unsuccessful edit" do
    log_in_as(@user, 'password', 1)
    get edit_user_player_profiles_path(@user)
    patch user_player_profiles_path, params: {player_profile: {
      bio: nil
      }}
    assert_template 'player_profiles/edit'
  end

  test "correctly routes after a successful edit" do
    log_in_as(@user, 'password', 1)
    bio = "New bio"
    get edit_user_player_profiles_path(@user)
    patch user_player_profiles_path, params: { player_profile: {
      bio: bio, experience_level: 3
    }}
    assert_redirected_to user_player_profiles_path(@user, @player_profile)
    @player_profile.reload
    assert_equal bio, @player_profile.bio
  end
end
