require 'test_helper'

#The functionality at the moment is all set. However, I'm trying to test a strange
#part: you know how controllers of items have special variables that can be used in
#its views via erb commands? I'm trying to access those, but it's not working right
#now... -Cameron C.
class SearchPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    #byebug
    @p1 = player_profiles(:one)
    @p2 = player_profiles(:two)
    @dm1 = dm_profiles(:one)
    @dm2 = dm_profiles(:two)
  end

  #include Rails.application.routes.url_helpers

  test "can visit the search page" do
    get search_pages_search_path
    assert_response :success
  end

  test "can retrieve PlayerProfile 1" do
    @params = {:experience_level => 3, :ruleset1 => 2,
      :profile_type => 0, :online_play => 1, :module => 1}
    get search_pages_results_path(@params)
    assert_response :success
    assert_equal(@p1, User.search(@params).first)
  end

  test "can retrieve Player Profile 2" do
    @params = {:experience_level => 1, :ruleset1 => 2,
      :profile_type => 0, :online_play => 0, :module => 0}
      get search_pages_results_path(@params)
      assert_response :success
    assert_equal(@p2, User.search(@params).first)
  end

  test "gives no results for a Player Profile search" do
    #get search_pages_search_path
    #somehow put in and submit the search parameters (NO idea how to do that...)
    #redirect_to search_pages_results_path
    #assert @users.count == 0
    @params = {:experience_level => 1, :ruleset1 => 2,
      :profile_type => 0, :online_play => 0, :module => 1}
      get search_pages_results_path(@params)
      assert_response :success
    assert User.search(@params).count == 0
    #How do you assert a message showing up?
  end


  test "can retrieve DmProfile 1" do
    @params = {:experience_level => 1, :ruleset1 => 3,
      :profile_type => 1, :online_play => 1, :module => 1}
    get search_pages_results_path(@params)
    assert_response :success
    assert_equal(@dm1, User.search(@params).first)
  end

  test "can retrieve DmProfile 2" do
    @params = {:experience_level => 3, :ruleset1 => 2,
      :profile_type => 1, :online_play => 0, :module => 0}
    get search_pages_results_path(@params)
    assert_response :success
    assert_equal(@dm2, User.search(@params).first)
  end

  test "gives no results for a DM Profile search" do
    @params = {:experience_level => 1, :ruleset1 => 2,
      :profile_type => 1, :online_play => 0, :module => 1}
    get search_pages_results_path(@params)
    assert_response :success
    assert User.search(@params).count == 0
    #How do you assert a message showing up?
  end

  test "can redirect to search page for another search" do
    @params = {:experience_level => 3, :ruleset1 => 2,
      :profile_type => 0, :online_play => 1, :module => 1}
    get search_pages_results_path(@params)
    assert_response :success
    assert_select "a[href=?]", search_pages_search_path

  end
end
