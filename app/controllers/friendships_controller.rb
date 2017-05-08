class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:user_id])
    if !current_user.blocked_by?(User.find_by(id: params[:user_id])) && !current_user.friends_with?(User.find_by(id: params[:user_id]))
      if @friendship.save
        flash[:success] = "Added friend"
      else
        flash[:danger] = "Unabled to add friend"
      end
    end
    redirect_to :back
  end

  def destroy
    @friendship = Friendship.where("user_id = ?", current_user.id)[0]
    @friendship.destroy if @friendship != nil
    redirect_to :back
  end

  def index
    redirect_to root_path if !logged_in? || current_user.id != params[:user_id].to_i
    @user = current_user
    @friends = @user.friends if !@user.nil?
    @blocked = @user.blockeds
  end
end
