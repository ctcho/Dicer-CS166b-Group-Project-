require 'test_helper'
include SessionsHelper

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
    #@u7 = users(:user_7)
    #@u8 = users(:user_8)
    #@u9 = users(:user_9)
    #@u10 = users(:user_10)
    @searcher = users(:searcher)
    @p1 = player_profiles(:one)
    @p2 = player_profiles(:two)
    @p3 = PlayerProfile.create(user_id: 2, bio: "My Text", experience_level: 4, online_play: 1, homebrew: 0,
      original_ruleset: 1, advanced_ruleset: 0, pathfinder: 0, third: 1, three_point_five: 1, fourth: 0,
      fifth: 0, original_campaign: 0, module: 1)
    @p0 = PlayerProfile.create(user_id: 3, bio: "My Text", experience_level: 2, online_play: 1, homebrew: 0,
      original_ruleset: 0, advanced_ruleset: 0, pathfinder: 0, third: 0, three_point_five: 0, fourth: 0,
      fifth: 0, original_campaign: 0, module: 0)
    #@p4
    #@p5
    @dm1 = dm_profiles(:one)
    @dm2 = dm_profiles(:two)
    @dm3 = DmProfile.create(user_id: 2, bio: "My Text", experience_level: 4, online_play: 1, homebrew: 0,
    original_ruleset: 1, advanced_ruleset: 0, pathfinder: 0, third: 1, three_point_five: 1, fourth: 0,
    fifth: 0, original_campaign: 0, module: 1)
    #@dm4
    #@dm5
    @u1.player_profile = @p1
    @u2.player_profile = @p2
    @u3.dm_profile = @dm1
    @u4.dm_profile = @dm2
    @u5.player_profile = @p3
    @u6.dm_profile = @dm3
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
    assert User.search(@params).count > 0
    assert User.search(@params).first.class == PlayerProfile
  end

  test "not giving a search option will use the 'AND' feature by default" do
    @params = {profile_type: "0"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params).count > 0
    assert User.search(@params).first.class == PlayerProfile
  end

  test "a user will not find themselves in a search" do
    @params = {option: "AND", profile_type: "0", experience_level: "2", online_play: "1"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params).count == 1
    assert_select "p", "There are no users that match your given preferences."
  end

  test "can redirect to search page for another search" do
    @params = {option: "AND", profile_type: "0", homebrew: "1"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    assert_select "a[href=?]", search_pages_search_path
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
    #assert User.search(@params).count == 1
    assert User.search(@params).include?(@p2)
    assert_select "div.row"
  end

  test "can retrieve PlayerProfile 2 without using all parameters, part 1" do
    @params = {option: "AND", profile_type: "0", homebrew: "1", original_ruleset: "2",
      advanced_ruleset: "3", pathfinder: "4", third: "5", online_play: "0", campaign_type: "0"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params).include?(@p2)
    assert_select "div.row"
  end

  test "can retrieve PlayerProfile 2 without using all parameters, part 2" do
    @params = {option: "AND", profile_type: "0", experience_level: "1", advanced_ruleset: "3", pathfinder: "4",
      third: "5", three_point_five: "6", fourth: "7", fifth: "8"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params).include?(@p2)
    assert_select "div.row"
  end

  test "can retrieve PlayerProfile 2 without using all parameters, part 3" do
    @params = {option: "AND", profile_type: "0", experience_level: "1", online_play: "0"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    #assert User.search(@params).count == 1
    assert User.search(@params).include?(@p2)
    assert_select "div.row"
  end

  test "can retrieve PlayerProfile 1" do
    @params = {option: "AND", profile_type: "0", experience_level: "3", homebrew: "1", original_ruleset: "2",
      third: "5", three_point_five: "6", fourth: "7", fifth: "8", online_play: "1", campaign_type: "0"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params).include?(@p1)
    assert_select "div.row"
  end

  test "can retrieve PlayerProfile 1 without using all parameters, part 1" do
    @params = {option: "AND", profile_type: "0", experience_level: "3", third: "5", three_point_five: "6",
      fourth: "7", fifth: "8", online_play: "1", campaign_type: "0"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params).include?(@p1)
    assert_select "div.row"
  end

  test "can retrieve PlayerProfile 1 without using all parameters, part 2" do
    @params = {option: "AND", profile_type: "0",homebrew: "1", original_ruleset: "2",
      third: "5", three_point_five: "6", online_play: "1", campaign_type: "0"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params).include?(@p1)
    assert_select "div.row"
  end

  test "can retrieve PlayerProfile 1 without using all parameters, part 3" do
    @params = {option: "AND", profile_type: "0", experience_level: "3", online_play: "1"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params).include?(@p1)
    assert_select "div.row"
  end

  test "some parameter combinations get multiple PlayerProfiles, part 1" do
    @params = {option: "AND", profile_type: "0", third: "5", three_point_five: "6", fourth: "7", fifth: "8"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params).count > 1
  end

  test "some parameter combinations get multiple PlayerProfiles, part 2" do
    @params = {option: "AND", profile_type: "0", campaign_type: "0"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params).count > 1
  end

  test "a user cannot find a player unwilling to travel to their location" do
    @params = {option: "AND", profile_type: "0", experience_level: "4", online_play: "1",
      original_ruleset: "2", third: "5", three_point_five: "6", campaign_type: "1"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
      get search_pages_results_path(@params)
      assert_response :success
      #puts "#{User.search(@params).count}"
      #byebug
      assert User.search(@params).count == 1
      assert_select "p", "There are no users that match your given preferences."
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
    assert User.search(@params).include?(@dm2)
    assert_select "div.row"
  end

  test "can retrieve DmProfile 2 without using all parameters, part 1" do
    @params = {option: "AND", profile_type: "1", experience_level: "3", homebrew: "1",
      advanced_ruleset: "3", pathfinder: "4", third: "5", fourth: "7", fifth: "8"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params).include?(@dm2)
    assert_select "div.row"
  end

  test "can retrieve DmProfile 2 without using all parameters, part 2" do
    @params = {option: "AND", profile_type: "1", advanced_ruleset: "3", pathfinder: "4", third: "5",
      fourth: "7", fifth: "8", online_play: "0", campaign_type: "0"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params).include?(@dm2)
    assert_select "div.row"
  end

  test "can retrieve DmProfile 2 without using all parameters, part 3" do
    @params = {option: "AND", profile_type: "1", experience_level: "3", online_play: "0", campaign_type: "0"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params).include?(@dm2)
    assert_select "div.row"
  end

  test "can retrieve DmProfile 1" do
    @params = {option: "AND", profile_type: "1", experience_level: "1", homebrew: "1", advanced_ruleset: "3",
      three_point_five: "6", fourth: "7", fifth: "8", online_play: "1", campaign_type: "1"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params).include?(@dm1)
    assert_select "div.row"
  end

  test "can retrieve DmProfile 1 without using all parameters, part 1" do
    @params = {option: "AND", profile_type: "1", experience_level: "1", advanced_ruleset: "3",
      three_point_five: "6", fourth: "7", fifth: "8"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params).count == 1
    assert User.search(@params).include?(@dm1)
    assert_select "div.row"
  end

  test "can retrieve DmProfile 1 without using all parameters, part 2" do
    @params = {option: "AND", profile_type: "1", three_point_five: "6", fourth: "7", fifth: "8",
      online_play: "1", campaign_type: "1"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params).include?(@dm1)
    assert_select "div.row"
  end

  test "can retrieve DmProfile 1 without using all parameters, part 3" do
    @params = {option: "AND", profile_type: "1", experience_level: "1", online_play: "1", campaign_type: "1"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params).count == 1
    assert_equal(@dm1, User.search(@params).first)
    assert_select "div.row", 1
  end

  test "some parameter combinations get multiple DmProfiles, part 1" do
    @params = {option: "AND", profile_type: "1", fourth: "7", fifth: "8"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params).count > 1
  end

  test "some parameter combinations get multiple DmProfiles, part 2" do
    @params = {option: "AND", profile_type: "1", homebrew: "1", advanced_ruleset: "3", campaign_type: "0"}
    if current_user.nil?
      log_in_as(@searcher, "search", 0)
    end
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params).count > 1
  end

  test "a user cannot find a DM unwilling to travel to their location" do
    @params = {option: "AND", profile_type: "1", experience_level: "4", online_play: "1",
      original_ruleset: "2", third: "5", three_point_five: "6", campaign_type: "1"}
      if current_user.nil?
        log_in_as(@searcher, "search", 0)
      end
      get search_pages_results_path(@params)
      assert_response :success
      #puts "#{User.search(@params).count}"
      assert User.search(@params).count == 1
      assert_select "p", "There are no users that match your given preferences."
  end

end
