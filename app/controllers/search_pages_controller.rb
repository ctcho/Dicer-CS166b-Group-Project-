class SearchPagesController < ApplicationController
include SearchPagesHelper
  before_action :logged_in_user

  #restrict availability of search function for now to logged in users
  def search
  end

  #def find_by_username
    #byebug
  #  key = params[:key]
    #sql_conditions = "username LIKE #{key}%"
    #puts sql_conditions
  #  results = User.where("username ILIKE ?", "#{key}%")
    #puts results
  #  byebug
  #  render json: {message: "Success2"}

  #end

  def results
    #Goes to User.search in user model --Cameron C.
    @profile = params[:profile_type]
    @users = User.search(params, current_user)
    #puts "\n\nSearch Results: #{@users.class}\n\n"
    #byebug
    @users_in_range = User.location(current_user, params[:profile_type])
    #puts "\n\nUsers in range of searcher: #{@users_in_range.class}\n\n"
    @users = @users & @users_in_range #since @users is an array, .merge won't work...
    @has_valid = has_valid_users(@users)
    @user = current_user
  end

  private
    def logged_in_user
      unless logged_in?
        store_location
        redirect_to login_url, notice: "In order to protect our users' privacy, an account is required to access user search. Please log in or create an account."
      end
    end
end
