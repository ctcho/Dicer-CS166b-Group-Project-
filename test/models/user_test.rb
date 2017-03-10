
require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "can be created" do
    assert_difference('User.count') do
      u = User.create(username: "TestUser0", email: "example0@railstutorial.com", password: "foobar", address: "415 South St, Waltham MA")
    end
  end

<<<<<<< HEAD
	#These tests were written by Michael Spittler to test the functionality of the Geolocation verification on the user model.
	#Users enter some geolocatable address, e.g. a direct address, just a zip-code, or direct coordinates, and the lat and lng
	#columns of the user table to be used for distance searches with the Geokit-rails gem. 

    it "can geocode addresses" do
      u = User.create(username: "TestUser1", email: "example1@railstutorial.com", password: "foobar", address: "1600 Pennsylvania Ave NW, Washington, DC")
      u.lat.must_be_close_to 38.8977, 0.01
      u.lng.must_be_close_to -77.0365, 0.01
    end
=======
  test "can geocode address" do
    u = User.create(username: "TestUser1", email: "example1@railstutorial.com", password: "foobar", address: "1600 Pennsylvania Ave NW, Washington, DC")
    assert_in_delta u.lat, 38.8977, 0.01
    assert_in_delta u.lng, -77.0365, 0.01
  end
>>>>>>> f5008cce47632e8da61b98e973df69baffea5551

  test "can geocode zipcodes" do
    u = User.create(username: "TestUser2", email: "example2@railstutorial.com", password: "foobar", address: "02453")
      assert_in_delta u.lat, 42.36, 0.01
      assert_in_delta u.lng, -71.25, 0.01
    end

  test "can geocode coordinates" do
    u = User.create(username: "TestUser3", email: "example3@railstutorial.com", password: "foobar",password_confirmation: "foobar", address: "48.8584, 2.2945")
    assert_in_delta u.lat, 48.85, 0.01
    assert_in_delta u.lng, 2.29, 0.01
    assert u.valid?
  end

  test "rejects invalid addresses" do
    u = User.create(username: "TestUser", email: "example@railstutorial.com", password: "foobar", password_confirmation: "foobar", address: "clearly not an address")
    assert !u.valid?
  end

  test "stores emails in lowercase" do
    u = User.create(username: "TestUser4", email: "aBcDefGH@railstutorial.cOm", password: "foobar", password_confirmation: "foobar", address: "02453")
    assert_equal(u.email, "abcdefgh@railstutorial.com")
  end

  test "will not save with a password of 5 or fewer characters" do
    u = User.create(username: "TestUser5", email: "example5@railstutorial.com", password: "foo", password_confirmation: "foo", address:"02453" )
    assert !u.valid?
  end

  test "will not save without a matching password_confirmation" do
    u = User.create(username: "TestUser6", email: "example6@railstutorial.com", password: "foobar")
    assert !u.valid?
    end

  test "should return false from authenticated? if it has a nil digest" do
    u = User.create(username: "TestUser7", email: "example7@railstutorial.com", password: "foobar", password_confirmation: "foobar", address: "02453")
    assert !u.authenticated?('')
  end

end
