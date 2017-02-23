require 'test_helper'

class HomePagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get home_pages_home_url
    assert_response :success
  end

  test "should get about" do
    get home_pages_about_url
    assert_response :success
  end

  test "should get contact" do
    get home_pages_contact_url
    assert_response :success
  end

  test "should get resources" do
    get home_pages_resources_url
    assert_response :success
  end

end
