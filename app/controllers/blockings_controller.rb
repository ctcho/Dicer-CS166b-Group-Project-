class BlockingsController < ApplicationController
  def create
    if !current_user.blocked_by?(User.find(params[:user_id]))
      @blocking = current_user.blockings.build(blocked_id: params[:user_id])
      @blocking.save!
    end
    redirect_to current_user
  end

  def destroy
    @blocking = Blocking.find_by(user_id: current_user.id)
    @blocking_reciprocal = Blocking.find_by(blocked_id: params[:user_id])
    @blocking.destroy
    @blocking_reciprocal.destroy
    redirect_to :back
  end
end
