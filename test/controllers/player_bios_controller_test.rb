require 'test_helper'

class PlayerBiosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player_bio = player_bios(:one)
  end

  test "should get index" do
    get player_bios_url
    assert_response :success
  end

  test "should get new" do
    get new_player_bio_url
    assert_response :success
  end

  test "should create player_bio" do
    assert_difference('PlayerBio.count') do
      post player_bios_url, params: { player_bio: { bio: @player_bio.bio, exp_level: @player_bio.exp_level, ruleset1: @player_bio.ruleset1, ruleset2: @player_bio.ruleset2, ruleset3: @player_bio.ruleset3, ruleset4: @player_bio.ruleset4 } }
    end

    assert_redirected_to player_bio_url(PlayerBio.last)
  end

  test "should show player_bio" do
    get player_bio_url(@player_bio)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_bio_url(@player_bio)
    assert_response :success
  end

  test "should update player_bio" do
    patch player_bio_url(@player_bio), params: { player_bio: { bio: @player_bio.bio, exp_level: @player_bio.exp_level, ruleset1: @player_bio.ruleset1, ruleset2: @player_bio.ruleset2, ruleset3: @player_bio.ruleset3, ruleset4: @player_bio.ruleset4 } }
    assert_redirected_to player_bio_url(@player_bio)
  end

  test "should destroy player_bio" do
    assert_difference('PlayerBio.count', -1) do
      delete player_bio_url(@player_bio)
    end

    assert_redirected_to player_bios_url
  end
end
