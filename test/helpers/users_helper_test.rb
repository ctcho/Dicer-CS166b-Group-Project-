require 'test_helper'
include UsersHelper

class UsersHelperTest <ActionDispatch::IntegrationTest

  def setup
    @user1 = users(:one)
    @user2 = users(:two)
    @user1.dm_profile = dm_profiles(:one)
    @user2.dm_profile = dm_profiles(:two)
  end

  test "correctly translates experience level" do
    assert_equal translate_experience_level(@user1.dm_profile.experience_level), "Beginner (0-1 years of play)"
  end

  test "correctly translates online play" do
    assert_equal translate_online_play(@user1.dm_profile), "Willing to play online"
    assert_not_equal translate_online_play(@user2.dm_profile), "Willing to play online"
  end

  test "returns correct distance" do
    distance = find_distance(@user1, @user2).gsub(/[^\d\.]/, '').to_f
    assert_in_delta 615, distance, 10
  end

  test "gets correct number of rulesets" do
    assert_equal get_ruleset_strings(@user1.dm_profile).count, 4
  end

  test "correctly says users aren't in range" do
    assert_not within_distance(@user1, @user2)
  end

  test "correctly says users are in range" do
    newuser = users(:one)
    assert within_distance(@user1, newuser)
  end

end
