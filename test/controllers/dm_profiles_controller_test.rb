require 'test_helper'
require 'byebug'

class DmProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dm_profile = dm_profiles(:one)
    @user = users(:one)
    @dm_profile.update(user: @user)
  end

  test "should get index" do
    get user_dm_profiles_url(@user, @dm_profile)
    assert_response :success
  end

  test "should get new" do
    get new_user_dm_profiles_url(@user)
    assert_response :success
  end

  test "should create dm_profile" do
    assert_difference('DmProfile.count') do
      post user_dm_profiles_url(@user), params: { dm_profile: {
                                              advanced_ruleset: @dm_profile.advanced_ruleset,
                                              bio: @dm_profile.bio,
                                              experience_level: @dm_profile.experience_level,
                                              fifth: @dm_profile.fifth,
                                              fourth: @dm_profile.fourth,
                                              homebrew: @dm_profile.homebrew,
                                              max_distance: @dm_profile.max_distance,
                                              module: @dm_profile.module,
                                              online_play: @dm_profile.online_play,
                                              original_campaign: @dm_profile.original_campaign,
                                              original_ruleset: @dm_profile.original_ruleset,
                                              pathfinder: @dm_profile.pathfinder,
                                              third: @dm_profile.third,
                                              three_point_five: @dm_profile.three_point_five,
                                              user_id: @dm_profile.user_id } }

    end

    assert_redirected_to user_dm_profiles_url(@user, DmProfile.last)
  end

  test "should show dm_profile" do
    get user_dm_profiles_url(@user, @dm_profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_dm_profiles_url(@user, @dm_profile)
    assert_response :success
  end

  test "should update dm_profile" do
    patch user_dm_profiles_url(@user), params: { dm_profile: { advanced_ruleset: @dm_profile.advanced_ruleset, bio: @dm_profile.bio, experience_level: @dm_profile.experience_level, fifth: @dm_profile.fifth, fourth: @dm_profile.fourth, homebrew: @dm_profile.homebrew, max_distance: @dm_profile.max_distance, module: @dm_profile.module, online_play: @dm_profile.online_play, original_campaign: @dm_profile.original_campaign, original_ruleset: @dm_profile.original_ruleset, pathfinder: @dm_profile.pathfinder, third: @dm_profile.third, three_point_five: @dm_profile.three_point_five, user_id: @dm_profile.user_id } }
    assert_redirected_to user_dm_profiles_url(@user, @dm_profile)
  end

  test "should destroy dm_profile" do
    assert_difference('DmProfile.count', -1) do
      delete user_dm_profiles_url(@user)
    end

    assert_redirected_to user_dm_profiles_url
  end
end
