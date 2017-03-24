require 'test_helper'

#The functionality at the moment is all set. However, I'm trying to test a strange
#part: you know how controllers of items have special variables that can be used in
#its views via erb commands? I'm trying to access those, but it's not working right
#now... -Cameron C.
class SearchPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    #byebug
    @u1 = User.create(email: "us1@example.com", password: "strongpass", password_confirmation: "strongpass",
      username: "unique_names", age: 18, address: "02453", max_distance: 30.0)
      #byebug
    @u2 = User.create(email: "us2@example.com", password: "strongpass2", password_confirmation: "strongpass2",
      username: "unique_names2", age: 18, address: "02453", max_distance: 30.0)
    @u3 = User.create(email: "us3@example.com", password: "strongpass3", password_confirmation: "strongpass3",
      username: "unique_names3", age: 18, address: "02453", max_distance: 30.0)
    @u4 = User.create(email: "us4@example.com", password: "strongpass4", password_confirmation: "strongpass4",
      username: "unique_names4", age: 18, address: "02453", max_distance: 30.0)
    log_in_as(@u1, "strongpass", 1)
    @p1 = player_profiles(:one)
    @p2 = player_profiles(:two)
    @dm1 = dm_profiles(:one)
    @dm2 = dm_profiles(:two)
    @u1.player_profile = @p1
    @u2.player_profile = @p2
    @u3.dm_profile = @dm1
    @u4.dm_profile = @dm2
    #byebug
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
      #byebug
    get search_pages_results_path(@params)
    #byebug
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
