class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:user_id])
    if !current_user.blocked_by?(User.find_by(params[:user_id]))
      if @friendship.save
        flash[:success] = "Added friend"
      else
        flash[:danger] = "Unabled to add friend"
      end
    end
    redirect_to :back
  end

  def destroy 
  end
end
