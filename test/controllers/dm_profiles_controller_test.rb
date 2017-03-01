require 'test_helper'

class DmProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dm_profile = dm_profiles(:one)
    @dm_profile.user_id = User.first.id
    @dm_profile.save
  end

  test "should get index" do
    get dm_profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_dm_profile_path
    assert_response :success
  end

  test "should create dm_profile" do
    assert_difference('DmProfile.count') do
      post dm_profiles_url, params: { dm_profile: {user_id: @dm_profile.user_id, bio: @dm_profile.bio, exp_level: @dm_profile.exp_level, ruleset1: @dm_profile.ruleset1, ruleset2: @dm_profile.ruleset2, ruleset3: @dm_profile.ruleset3, ruleset4: @dm_profile.ruleset4 } }
    end

    assert_redirected_to dm_profile_url(DmProfile.last)
  end

  test "should show dm_profile" do
    get dm_profile_url(@dm_profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_dm_profile_url(@dm_profile)
    assert_response :success
  end

    test "should update dm_profile" do
    patch dm_profile_url(@dm_profile), params: { dm_profile: { id: @dm_profile.id, bio: @dm_profile.bio, exp_level: @dm_profile.exp_level, ruleset1: @dm_profile.ruleset1, ruleset2: @dm_profile.ruleset2, ruleset3: @dm_profile.ruleset3, ruleset4: @dm_profile.ruleset4 } }
    #assert_redirected_to dm_profile_url(@DmProfilesControllerTest)
    assert_redirected_to dm_profile_url(DmProfile.last)
  end

  test "should destroy dm_profile" do
    assert_difference('DmProfile.count', -1) do
      delete dm_profile_url(@dm_profile)
    end

    assert_redirected_to dm_profiles_url
  end
end
