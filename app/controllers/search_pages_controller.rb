class SearchPagesController < ApplicationController
  def search
  end

  def results
    @players = PlayerProfile.where("exp_level = ? AND ruleset = ?", params[:exp_level], params[:ruleset])
  end
end
