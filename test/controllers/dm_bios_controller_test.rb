require 'test_helper'

class DmBiosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dm_bio = dm_bios(:one)
  end

  test "should get index" do
    get dm_bios_url
    assert_response :success
  end

  test "should get new" do
    get new_dm_bio_url
    assert_response :success
  end

  test "should create dm_bio" do
    assert_difference('DmBio.count') do
      post dm_bios_url, params: { dm_bio: { bio: @dm_bio.bio, exp_level: @dm_bio.exp_level, ruleset1: @dm_bio.ruleset1, ruleset2: @dm_bio.ruleset2, ruleset3: @dm_bio.ruleset3, ruleset4: @dm_bio.ruleset4 } }
    end

    assert_redirected_to dm_bio_url(DmBio.last)
  end

  test "should show dm_bio" do
    get dm_bio_url(@dm_bio)
    assert_response :success
  end

  test "should get edit" do
    get edit_dm_bio_url(@dm_bio)
    assert_response :success
  end

  test "should update dm_bio" do
    patch dm_bio_url(@dm_bio), params: { dm_bio: { bio: @dm_bio.bio, exp_level: @dm_bio.exp_level, ruleset1: @dm_bio.ruleset1, ruleset2: @dm_bio.ruleset2, ruleset3: @dm_bio.ruleset3, ruleset4: @dm_bio.ruleset4 } }
    assert_redirected_to dm_bio_url(@dm_bio)
  end

  test "should destroy dm_bio" do
    assert_difference('DmBio.count', -1) do
      delete dm_bio_url(@dm_bio)
    end

    assert_redirected_to dm_bios_url
  end
end
