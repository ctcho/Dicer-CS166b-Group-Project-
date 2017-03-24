ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"


# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  #require_relative '/../app/helpers/sessions_helper.rb'
  include SessionsHelper
  # Add more helper methods to be used by all tests here...

  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in_as(user, password, remember_me)
    post login_path, params: { session: { email: user.email,
      password: password, remember_me: remember_me}}
  end

end
