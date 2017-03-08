
require 'test_helper'

class UserTest < ActiveSupport::TestCase

  describe User do
    before do
      User.destroy_all
    end

    it "can be created" do
      u = User.create(username: "TestUser", email: "example@railstutorial.com", password: "foobar", address: "415 South St, Waltham MA")
      u.valid?.must_equal true
      User.count.must_equal 1
    end

	#These tests were written by Michael Spittler to test the functionality of the Geolocation verification on the user model.
	#Users enter some geolocatable address, e.g. a direct address, just a zip-code, or direct coordinates, and the lat and lng
	#columns of the user table to be used for distance searches with the Geokit-rails gem. 

    it "can geocode addresses" do
      u = User.create(username: "TestUser", email: "example@railstutorial.com", password: "foobar", address: "1600 Pennsylvania Ave NW, Washington, DC")
      u.lat.must_be_close_to 38.8977, 0.01
      u.lng.must_be_close_to -77.0365, 0.01
    end

    it "can geocode zipcodes" do
      u = User.create(username: "TestUser", email: "example@railstutorial.com", password: "foobar", address: "02453")
      u.lat.must_be_close_to 42.36, 0.01
      u.lng.must_be_close_to -71.25, 0.01
    end

    it "can geocode coordinates" do
      u = User.create(username: "TestUser", email: "example@railstutorial.com", password: "foobar", address: "48.8584, 2.2945")
      u.lat.must_be_close_to 48.85, 0.01
      u.lng.must_be_close_to 2.29, 0.01
      u.valid?.must_equal true
    end

    it "rejects invalid addresses" do
      u = User.create(username: "TestUser", email: "example@railstutorial.com", password: "foobar", address: "clearly not an address")
      u.valid?.must_equal false
    end
  end

end
