class SearchPagesController < ApplicationController
include SearchPagesHelper
  before_action :logged_in_user

  #restrict availability of search function for now to logged in users
  def search
  end

  def results
    #sorter = SearchAdapter.new
    #Prototype until I truly understand how to make a better search
    #Goes to User.search in user model --Cameron C.
    @profile = params[:profile_type]
    @users = User.search(params)
    #byebug
    @users_in_range = User.location(current_user, params[:profile_type])
    @users = @users.merge(@users_in_range)
    @has_valid = has_valid_users(@users)
    #Current idea:
    #Get a list of player/DM profiles. (Class = ActiveRecord::Relation)
    #Get a list of user profiles within the radius of the current user. (Class = ActiveRecord::Relation)
    #In the results panel, search through the list of users in the user list.
    #If that user has a player/DM profile and it's in the compiled list of user/DM profiles,
    #Show that user in the results.
  end

  private
    def logged_in_user
      unless logged_in?
        store_location
        redirect_to login_url, notice: "In order to protect our users' privacy, an account is required to access user search. Please log in or create an account."
      end
    end
end
