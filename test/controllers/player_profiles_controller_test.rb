require 'test_helper'

class PlayerProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @player_profile = player_profiles(:one)
    @player_profile.user_id = @user.id
    @player_profile.save
  end

  test "should get index" do
    get user_player_profiles_url(@user, @player_profile)
    assert_response :success
  end

  test "should get new" do
    get new_user_player_profiles_url(@user)
    assert_response :success
  end

  test "should create player_profile" do
    assert_difference('PlayerProfile.count') do
      post user_player_profiles_url(@user), params: { player_profile: { advanced_ruleset: @player_profile.advanced_ruleset, bio: @player_profile.bio, experience_level: @player_profile.experience_level, fifth: @player_profile.fifth, fourth: @player_profile.fourth, homebrew: @player_profile.homebrew, max_distance: @player_profile.max_distance, module: @player_profile.module, online_play: @player_profile.online_play, original_campaign: @player_profile.original_campaign, original_ruleset: @player_profile.original_ruleset, pathfinder: @player_profile.pathfinder, third: @player_profile.third, three_point_five: @player_profile.three_point_five, user_id: @player_profile.user_id } }
    end

    assert_redirected_to user_player_profiles_url(@user, PlayerProfile.last)
  end

  test "should show player_profile" do
    get user_player_profiles_url(@user, @player_profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_player_profiles_url(@user, @player_profile)
    assert_response :success
  end

  test "should update player_profile" do
    patch user_player_profiles_url(@user), params: { player_profile: { advanced_ruleset: @player_profile.advanced_ruleset, bio: @player_profile.bio, experience_level: @player_profile.experience_level, fifth: @player_profile.fifth, fourth: @player_profile.fourth, homebrew: @player_profile.homebrew, max_distance: @player_profile.max_distance, module: @player_profile.module, online_play: @player_profile.online_play, original_campaign: @player_profile.original_campaign, original_ruleset: @player_profile.original_ruleset, pathfinder: @player_profile.pathfinder, third: @player_profile.third, three_point_five: @player_profile.three_point_five, user_id: @player_profile.user_id } }
    assert_redirected_to user_player_profiles_url(@user, @player_profile)
  end

  test "should destroy player_profile" do
    assert_difference('PlayerProfile.count', -1) do
      delete user_player_profiles_url(@user)
    end

    assert_redirected_to user_player_profiles_url
  end
end
