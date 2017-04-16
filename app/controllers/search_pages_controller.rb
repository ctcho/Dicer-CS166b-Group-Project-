class SearchPagesController < ApplicationController
include SearchPagesHelper

  def search
  end

  def results
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
end
