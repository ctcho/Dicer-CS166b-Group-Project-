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
  end
end
