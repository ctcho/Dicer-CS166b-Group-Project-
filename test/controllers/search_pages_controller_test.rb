require 'test_helper'
include SessionsHelper
include SearchPagesHelper
include UsersHelper

#The functionality at the moment is all set. However, I'm trying to test a strange
#part: you know how controllers of items have special variables that can be used in
#its views via erb commands? I'm trying to access those, but it's not working right
#now... -Cameron C.
class SearchPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    #byebug
    @u1 = users(:user_1)
    @u2 = users(:user_2)
    @u3 = users(:user_3)
    @u4 = users(:user_4)
    @u5 = users(:user_5)
    @u6 = users(:user_6)
    @u7 = users(:user_7)
    @u8 = users(:user_8)
    @u9 = users(:user_9)
    @u10 = users(:user_10)
    @u11 = users(:user_11)
    @u12 = users(:user_12)
    @u13 = users(:user_13)
    @u14 = users(:user_14)
    @u15 = users(:user_15)
    @u16 = users(:user_16)
    @searcher = users(:searcher)
    @p1 = player_profiles(:one)
    @p2 = player_profiles(:two)
    @p3 = PlayerProfile.create(user_id: 3, bio: "My Text", experience_level: 4, online_play: 1, homebrew: 0,
      original_ruleset: 1, advanced_ruleset: 0, pathfinder: 0, third: 1, three_point_five: 1, fourth: 0,
      fifth: 0, original_campaign: 0, module: 1)
    @p0 = PlayerProfile.create(user_id: 4, bio: "My Text", experience_level: 2, online_play: 1, homebrew: 0,
      original_ruleset: 0, advanced_ruleset: 0, pathfinder: 0, third: 0, three_point_five: 0, fourth: 0,
      fifth: 0, original_campaign: 0, module: 0)
    @p4 = PlayerProfile.create(user_id: 5, bio: "My Text", experience_level: 1, online_play: 0, homebrew: 0,
      original_ruleset: 0, advanced_ruleset: 0, pathfinder: 0, third: 1, three_point_five: 0, fourth: 1,
      fifth: 1, original_campaign: 0, module: 1)
    @p5 = PlayerProfile.create(user_id: 6, bio: "My Text", experience_level: 1, online_play: 0, homebrew: 0,
      original_ruleset: 0, advanced_ruleset: 0, pathfinder: 0, third: 1, three_point_five: 0, fourth: 1,
      fifth: 1, original_campaign: 0, module: 1)
    @p6 = PlayerProfile.create(user_id: 7, bio: "My Text", experience_level: 1, online_play: 0, homebrew: 0,
      original_ruleset: 0, advanced_ruleset: 0, pathfinder: 0, third: 1, three_point_five: 0, fourth: 1,
      fifth: 1, original_campaign: 0, module: 1)
    @p7 = PlayerProfile.create(user_id: 8, bio: "My Text", experience_level: 2, online_play: 1, homebrew: 0,
      original_ruleset: 0, advanced_ruleset: 0, pathfinder: 0, third: 1, three_point_five: 0, fourth: 1,
      fifth: 1, original_campaign: 0, module: 1)
    @p8 = PlayerProfile.create(user_id: 9, bio: "My Text", experience_level: 2, online_play: 1, homebrew: 0,
      original_ruleset: 0, advanced_ruleset: 0, pathfinder: 0, third: 1, three_point_five: 0, fourth: 1,
      fifth: 1, original_campaign: 0, module: 1)
    @dm1 = dm_profiles(:one)
    @dm2 = dm_profiles(:two)
    @dm3 = DmProfile.create(user_id: 3, bio: "My Text", experience_level: 4, online_play: 1, homebrew: 0,
    original_ruleset: 1, advanced_ruleset: 0, pathfinder: 0, third: 1, three_point_five: 1, fourth: 0,
    fifth: 0, original_campaign: 0, module: 1)
    @dm4 = DmProfile.create(user_id: 4, bio: "My Text", experience_level: 1, online_play: 0, homebrew: 0,
    original_ruleset: 1, advanced_ruleset: 0, pathfinder: 0, third: 1, three_point_five: 0, fourth: 1,
    fifth: 1, original_campaign: 0, module: 1)
    @dm5 = DmProfile.create(user_id: 5, bio: "My Text", experience_level: 1, online_play: 0, homebrew: 0,
    original_ruleset: 1, advanced_ruleset: 0, pathfinder: 0, third: 1, three_point_five: 0, fourth: 1,
    fifth: 1, original_campaign: 0, module: 1)
    @dm6 = DmProfile.create(user_id: 6, bio: "My Text", experience_level: 1, online_play: 0, homebrew: 0,
    original_ruleset: 1, advanced_ruleset: 0, pathfinder: 0, third: 1, three_point_five: 0, fourth: 1,
    fifth: 1, original_campaign: 0, module: 1)
    @dm7 = DmProfile.create(user_id: 7, bio: "My Text", experience_level: 2, online_play: 1, homebrew: 0,
      original_ruleset: 0, advanced_ruleset: 0, pathfinder: 0, third: 1, three_point_five: 0, fourth: 1,
      fifth: 1, original_campaign: 0, module: 1)
    @dm8 = DmProfile.create(user_id: 8, bio: "My Text", experience_level: 2, online_play: 1, homebrew: 0,
      original_ruleset: 0, advanced_ruleset: 0, pathfinder: 0, third: 1, three_point_five: 0, fourth: 1,
      fifth: 1, original_campaign: 0, module: 1)
    @u1.player_profile = @p1
    @u2.player_profile = @p2
    @u3.dm_profile = @dm1
    @u4.dm_profile = @dm2
    @u5.player_profile = @p3
    @u6.dm_profile = @dm3
    @u7.player_profile = @p4
    @u8.player_profile = @p5
    @u9.player_profile = @p6
    @u10.dm_profile = @dm4
    @u11.dm_profile = @dm5
    @u12.dm_profile = @dm6
    @u13.player_profile = @p7
    @u14.dm_profile = @dm7
    @u15.player_profile = @p8
    @u16.dm_profile = @dm8
    @searcher.player_profile = @p0
    log_in_as(@searcher, "search", 1)
  end
    #byebug
  #end

  #include Rails.application.routes.url_helpers

  test "can visit the search page" do
    get search_pages_search_path
    assert_response :success
  end

  test "not providing a profile type gets PlayerProfiles by default" do
    #puts "#{current_user.username}"
    @params = {option: "AND", experience_level: "1", homebrew: "1"}
    #byebug
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    #byebug
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params, current_user).count > 0
    assert User.search(@params, current_user).first.class == PlayerProfile
  end

  test "not giving a search option will use the 'AND' feature by default" do
    @params = {profile_type: "0"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params, current_user).count > 0
    assert User.search(@params, current_user).first.class == PlayerProfile
  end

  test "a user will not find themselves in a search" do
    @params = {option: "AND", profile_type: "0", experience_level: "2", online_play: "1"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    assert_not User.search(@params, current_user).include?(@p0)
    assert_select "#{@searcher.username}", 0
  end

  test "can redirect to search page for another search" do
    @params = {option: "AND", profile_type: "0", homebrew: "1"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    assert_select "button", "Search for Users..."
  end

  test "user will see recommendations based on only one profile type if they don't have the other" do
    get user_path(@searcher)
    assert_response :success
    recommendations = get_similar_profiles(@searcher)
    assert recommendations.count > 0
    assert recommendations.first.class == PlayerProfile
    assert recommendations.third.class == DmProfile
    #assert "div.profile-preview"
  end

  test "user will see recommendations based on both profile types if they have both profile types" do
    dm0 = DmProfile.create(user_id: 0, bio: "My Text", experience_level: 2, online_play: 1, homebrew: 0,
      original_ruleset: 0, advanced_ruleset: 0, pathfinder: 0, third: 0, three_point_five: 0, fourth: 0,
      fifth: 0, original_campaign: 0, module: 0)
    @searcher.dm_profile = dm0
    get user_path(@searcher)
    assert_response :success
    recommendations = get_similar_profiles(@searcher)
    assert recommendations.count > 0
    assert recommendations.first.class == PlayerProfile
    assert recommendations.third.class == DmProfile
    #assert "div.profile-preview", 2
  end



  test "can retrieve PlayerProfile 2" do
    @params = {option: "AND", profile_type: "0", experience_level: "1", homebrew: "1", original_ruleset: "2",
      advanced_ruleset: "3", pathfinder: "4", third: "5", three_point_five: "6", fourth: "7", fifth: "8",
      online_play: "0", campaign_type: "0"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    #assert User.search(@params, current_user).count == 1
    assert User.search(@params, current_user).include?(@p2)
    assert_select "div.profile-preview"
  end

  test "can retrieve PlayerProfile 2 without using all parameters, part 1" do
    @params = {option: "AND", profile_type: "0", homebrew: "1", original_ruleset: "2",
      advanced_ruleset: "3", pathfinder: "4", third: "5", online_play: "0", campaign_type: "0"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params, current_user).include?(@p2)
    assert_select "div.profile-preview"
  end

  test "can retrieve PlayerProfile 2 without using all parameters, part 2" do
    @params = {option: "AND", profile_type: "0", experience_level: "1", advanced_ruleset: "3", pathfinder: "4",
      third: "5", three_point_five: "6", fourth: "7", fifth: "8"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params, current_user).include?(@p2)
    assert_select "div.profile-preview"
  end

  test "can retrieve PlayerProfile 2 without using all parameters, part 3" do
    @params = {option: "AND", profile_type: "0", experience_level: "1", online_play: "0"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    #assert User.search(@params, current_user).count == 1
    assert User.search(@params, current_user).include?(@p2)
    assert_select "div.profile-preview"
  end

  test "can retrieve PlayerProfile 1" do
    @params = {option: "AND", profile_type: "0", experience_level: "3", homebrew: "1", original_ruleset: "2",
      third: "5", three_point_five: "6", fourth: "7", fifth: "8", online_play: "1", campaign_type: "0"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params, current_user).include?(@p1)
    assert_select "div.profile-preview"
  end

  test "can retrieve PlayerProfile 1 without using all parameters, part 1" do
    @params = {option: "AND", profile_type: "0", experience_level: "3", third: "5", three_point_five: "6",
      fourth: "7", fifth: "8", online_play: "1", campaign_type: "0"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params, current_user).include?(@p1)
    assert_select "div.profile-preview"
  end

  test "can retrieve PlayerProfile 1 without using all parameters, part 2" do
    @params = {option: "AND", profile_type: "0",homebrew: "1", original_ruleset: "2",
      third: "5", three_point_five: "6", online_play: "1", campaign_type: "0"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params, current_user).include?(@p1)
    assert_select "div.profile-preview"
  end

  test "can retrieve PlayerProfile 1 without using all parameters, part 3" do
    @params = {option: "AND", profile_type: "0", experience_level: "3", online_play: "1"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params, current_user).include?(@p1)
    assert_select "div.profile-preview"
  end

  test "some parameter combinations get multiple PlayerProfiles, part 1" do
    @params = {option: "AND", profile_type: "0", third: "5", three_point_five: "6", fourth: "7", fifth: "8"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params, current_user).count > 1
  end

  test "some parameter combinations get multiple PlayerProfiles, part 2" do
    @params = {option: "AND", profile_type: "0", campaign_type: "0"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params, current_user).count > 1
  end

  test "a user cannot find a player unwilling to travel to their location" do
    #attempting to find @p3
    @params = {option: "AND", profile_type: "0", experience_level: "4", online_play: "1",
      original_ruleset: "2", third: "5", three_point_five: "6", campaign_type: "1"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
      get search_pages_results_path(@params)
      assert_response :success
      #puts "#{User.search(@params, current_user).count}"
      #byebug
      assert_not User.search(@params, current_user).include?(@p3)
      assert_select "div.search-text", "There are no users that match your given preferences."
  end

  test "Using the 'OR' feature returns results from most relevant to least relevant for PlayerProfiles" do
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    @params = {option: "OR", profile_type: "0", experience_level: "3", online_play: "1",
      original_ruleset: "2", third: "5", three_point_five: "1", campaign_type: "1"}
    get search_pages_results_path(@params)
    assert_response :success
    #Intended Order: @p1, @p3, @p2
    assert_select "div.profile-preview"
    #byebug
    sorted = User.search(@params, current_user)
    #unsorted = PlayerProfile.all
    #byebug #Uncomment both these lines in case you need to prove to yourself this works...
    assert_equal(sorted.first, @p1)
    assert_equal(sorted.second, @p7)
    assert_equal(sorted.third, @p8)
  end

  test "A PlayerProfile will see up to 4 recommended PlayerProfiles" do
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get user_player_profiles_url(@u1, @p1)
    assert_response :success
    recommendations = recommend_set(User.recommender(@p1, "player"), @u1)
    assert recommendations.count == 4
    #puts assert_select "div.profile-preview"
    assert recommendations.first.class == PlayerProfile
  end

  test "A list of recommended PlayerProfiles is sorted from most relevant to least relevant" do
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get user_player_profiles_url(@u1, @p1)
    assert_response :success
    recommendations = recommend_set(User.recommender(@p1, "player"), @u1)
    assert recommendations.count == 4
    assert_equal(recommendations.first, @p2)
    assert_equal(recommendations.second, @p4)
    assert_equal(recommendations.third, @p5)
    assert_equal(recommendations.fourth, @p6)
  end

  test "the list of recommended PlayerProfiles does not include the one being viewed nor the searcher" do
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get user_player_profiles_url(@u1, @p1)
    assert_response :success
    recommendations = recommend_set(User.recommender(@p1, "player"), @u1)
    assert recommendations.count == 4
    assert_not recommendations.include?(@p1)
    assert_not recommendations.include?(@searcher)
  end

  test "the list of recommended PlayerProfiles does not include users 3+ years older than the one viewed" do
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get user_player_profiles_url(@u1, @p1)
    assert_response :success
    recommendations = recommend_set(User.recommender(@p1, "player"), @u1)
    assert recommendations.count == 4
    assert_not recommendations.include?(@p7)
  end



  test "can retrieve DmProfile 2" do
    #puts "#{current_user.username}"
    @params = {option: "AND", profile_type: "1", experience_level: "3", homebrew: "1", original_ruleset: "2",
      advanced_ruleset: "3", pathfinder: "4", third: "5", fourth: "7", fifth: "8", online_play: "0",
      campaign_type: "0"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params, current_user).include?(@dm2)
    assert_select "div.profile-preview"
  end

  test "can retrieve DmProfile 2 without using all parameters, part 1" do
    @params = {option: "AND", profile_type: "1", experience_level: "3", homebrew: "1",
      advanced_ruleset: "3", pathfinder: "4", third: "5", fourth: "7", fifth: "8"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params, current_user).include?(@dm2)
    assert_select "div.profile-preview"
  end

  test "can retrieve DmProfile 2 without using all parameters, part 2" do
    @params = {option: "AND", profile_type: "1", advanced_ruleset: "3", pathfinder: "4", third: "5",
      fourth: "7", fifth: "8", online_play: "0", campaign_type: "0"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params, current_user).include?(@dm2)
    assert_select "div.profile-preview"
  end

  test "can retrieve DmProfile 2 without using all parameters, part 3" do
    @params = {option: "AND", profile_type: "1", experience_level: "3", online_play: "0", campaign_type: "0"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params, current_user).include?(@dm2)
    assert_select "div.profile-preview"
  end

  test "can retrieve DmProfile 1" do
    @params = {option: "AND", profile_type: "1", experience_level: "1", homebrew: "1", advanced_ruleset: "3",
      three_point_five: "6", fourth: "7", fifth: "8", online_play: "1", campaign_type: "1"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params, current_user).include?(@dm1)
    assert_select "div.profile-preview"
  end

  test "can retrieve DmProfile 1 without using all parameters, part 1" do
    @params = {option: "AND", profile_type: "1", experience_level: "1", advanced_ruleset: "3",
      three_point_five: "6", fourth: "7", fifth: "8"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params, current_user).include?(@dm1)
    assert_select "div.profile-preview"
  end

  test "can retrieve DmProfile 1 without using all parameters, part 2" do
    @params = {option: "AND", profile_type: "1", three_point_five: "6", fourth: "7", fifth: "8",
      online_play: "1", campaign_type: "1"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params, current_user).include?(@dm1)
    assert_select "div.profile-preview"
  end

  test "can retrieve DmProfile 1 without using all parameters, part 3" do
    @params = {option: "AND", profile_type: "1", experience_level: "1", online_play: "1", campaign_type: "1"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params, current_user).count == 1
    assert_equal(@dm1, User.search(@params, current_user).first)
    assert_select "div.profile-preview", 1
  end

  test "some parameter combinations get multiple DmProfiles, part 1" do
    @params = {option: "AND", profile_type: "1", fourth: "7", fifth: "8"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params, current_user).count > 1
  end

  test "some parameter combinations get multiple DmProfiles, part 2" do
    @params = {option: "AND", profile_type: "1", homebrew: "1", advanced_ruleset: "3", campaign_type: "0"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params, current_user).count > 1
  end

  test "a user cannot find a DM unwilling to travel to their location" do
    #attempting to find @dm3
    @params = {option: "AND", profile_type: "1", experience_level: "4", online_play: "1",
      original_ruleset: "2", third: "5", three_point_five: "6", campaign_type: "1"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
      get search_pages_results_path(@params)
      assert_response :success
      #puts "#{User.search(@params, current_user).count}"
      assert_not User.search(@params, current_user).include?(@dm3)
      assert_select "div.search-text", "There are no users that match your given preferences."
  end

  test "Using the 'OR' feature returns results from most relevant to least relevant for DmProfiles" do
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    @params = {option: "OR", profile_type: "1", experience_level: "1", online_play: "1",
      third: "5", three_point_five: "1", campaign_type: "1"}
    get search_pages_results_path(@params)
    assert_response :success
    #Intended Order: @dm1, @dm3, @dm2
    assert_select "div.profile-preview"
    #byebug
    sorted = User.search(@params, current_user)
    #unsorted = DmProfile.all
    #byebug #Uncomment both these lines in case you need to prove to yourself this works...
    assert_equal(sorted.first, @dm1)
    assert_equal(sorted.second, @dm4)
    assert_equal(sorted.third, @dm5)
  end

  test "A DmProfile will see up to 4 recommended DmProfiles" do
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get user_dm_profiles_path(@u3, @dm1)
    assert_response :success
    recommendations = recommend_set(User.recommender(@dm1, "dm"), @u3)
    assert recommendations.count == 4
    #puts assert_select "div.profile-preview"
    assert recommendations.first.class == DmProfile
  end

  test "A list of recommended DmProfiles is sorted from most relevant to least relevant" do
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get user_dm_profiles_path(@u3, @dm1)
    assert_response :success
    recommendations = recommend_set(User.recommender(@dm1, "dm"), @u3)
    assert recommendations.count == 4
    assert_equal(recommendations.first, @dm2)
    assert_equal(recommendations.second, @dm4)
    assert_equal(recommendations.third, @dm5)
    assert_equal(recommendations.fourth, @dm6)
  end

  test "the list of recommended DmProfiles does not include the one being viewed nor the searcher" do
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get user_dm_profiles_path(@u3, @dm1)
    assert_response :success
    recommendations = recommend_set(User.recommender(@dm1, "dm"), @u3)
    assert recommendations.count == 4
    assert_not recommendations.include?(@dm1)
    assert_not recommendations.include?(@searcher)
  end

  test "the list of recommended DmProfiles does not include users 3+ years older than the one viewed" do
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get user_dm_profiles_url(@u3, @dm1)
    assert_response :success
    recommendations = recommend_set(User.recommender(@dm1, "dm"), @u3)
    assert recommendations.count == 4
    assert_not recommendations.include?(@dm7)
  end

end
