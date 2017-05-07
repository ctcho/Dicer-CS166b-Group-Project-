class BlockingsController < ApplicationController
  def create
    @blocking = current_user.blockings.build(blocked_id: params[:user_id])
    @blocking.save!
  end
end
