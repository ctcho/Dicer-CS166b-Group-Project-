class SearchPagesController < ApplicationController
  def search
  end

  def results
  #  @players = PlayerProfile.where("exp_level = ? AND ruleset = ? AND location = ?",
  #  "%#{params[:exp_level]}%", "%#{params[:ruleset]}%", "%#{params[:location]}%")

  #@players = PlayerProfile.where("exp_level LIKE ? AND ruleset1 = ? AND ruleset2 = ?
  #AND ruleset3 = ? AND ruleset4 = ?", params[:exp_level], params[:ruleset1], params[:ruleset2],
  #params[:ruleset3], params[:ruleset4])

  @players = PlayerProfile.where("experience_level LIKE ?", params[:experience_level])
  end
end
