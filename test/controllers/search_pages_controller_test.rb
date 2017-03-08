require 'test_helper'

class SearchPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get search_pages_search_url
    assert_response :success
  end

  test "should get results" do
    get search_pages_results_url
    assert_response :success
  end

end
