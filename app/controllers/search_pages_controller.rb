class SearchPagesController < ApplicationController
include SearchPagesHelper

  def search
  end

  def results
    #Goes to User.search in user model --Cameron C.
    @profile = params[:profile_type]
    @users = User.search(params)
    #puts "\n\nSearch Results: #{@users.class}\n\n"
    #byebug
    @users_in_range = User.location(current_user, params[:profile_type])
    #puts "\n\nUsers in range of searcher: #{@users_in_range.class}\n\n"
    if @users.class == PlayerProfile::ActiveRecord_Relation || @users.class == DmProfile::ActiveRecord_Relation
      @users = @users.merge(@users_in_range)
    else #User is searching for any given condition and @users is an array...
      @users = @users & @users_in_range
    end
    @has_valid = has_valid_users(@users)
  end
end
