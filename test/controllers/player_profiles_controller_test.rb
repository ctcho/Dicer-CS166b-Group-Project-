require 'test_helper'

class PlayerProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player_profile = player_profiles(:one)
    @player_profile.user = User.first
    @player_profile.save
  end

  test "should get index" do
    get player_profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_player_profile_url
    assert_response :success
  end

  test "should create player_profile" do
    assert_difference('PlayerProfile.count') do
      post player_profiles_url, params: { player_profile: {user_id: @player_profile.user_id, bio: @player_profile.bio, exp_level: @player_profile.exp_level, ruleset1: @player_profile.ruleset1, ruleset2: @player_profile.ruleset2, ruleset3: @player_profile.ruleset3, ruleset4: @player_profile.ruleset4 } }
    end
    assert_redirected_to player_profile_url(PlayerProfile.last)
  end

  test "should show player_profile" do
    get player_profile_url(@player_profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_profile_url(@player_profile)
    assert_response :success
  end

  test "should update player_profile" do
    patch player_profile_url(@player_profile.id), params: { player_profile: {user: User.first, bio: @player_profile.bio, exp_level: @player_profile.exp_level, ruleset1: @player_profile.ruleset1, ruleset2: @player_profile.ruleset2, ruleset3: @player_profile.ruleset3, ruleset4: @player_profile.ruleset4 } }
    assert_redirected_to player_profile_url(@player_profile)
  end

  test "should destroy player_profile" do
    assert_difference('PlayerProfile.count', -1) do
      delete player_profile_url(@player_profile)
    end

    assert_redirected_to player_profiles_url
  end
end
