class SearchPagesController < ApplicationController


  def search
  end

  def results
    #sorter = SearchAdapter.new
    #Prototype until I truly understand how to make a better search
    #Goes to User.search in user model --Cameron C.
    @profile = Integer(params[:profile_type])
    @users = User.search(params)
  end
end
