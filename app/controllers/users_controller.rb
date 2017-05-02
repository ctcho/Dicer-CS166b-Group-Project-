class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :show, :settings, :index]
  before_action :correct_user, only:[:edit, :update, :show]
  before_action :admin_user, only:[:index]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    #get their chats
    @user = current_user
    @conversations = @user.chat_rooms
    @new_conversations = @user.chat_rooms
    @similar_profiles = []
    if !@user.player_profile.nil? && @user.dm_profile.nil?
      similar_players = recommend_set(User.recommender(@user.player_profile), @user)
      @similar_profiles << similar_players.first
      @similar_profiles << similar_players.second
      @similar_profiles << similar_players.third
      @similar_profiles << similar_players.fourth
    elsif !@user.dm_profile.nil? && @user.player_profile.nil?
      similar_dms = recommend_set(User.recommender(@user.dm_profile), @user)
      @similar_profiles << similar_dms.first
      @similar_profiles << similar_dms.second
      @similar_profiles << similar_dms.third
      @similar_profiles << similar_dms.fourth
    else #user has both
      similar_players = recommend_set(User.recommender(@user.player_profile), @user)
      similar_dms = recommend_set(User.recommender(@user.dm_profile), @user)
      @similar_profiles << similar_players.first
      @similar_profiles << similar_players.second
      @similar_profiles << similar_dms.first
      @similar_profiles << similar_dms.second
    end
    @similar_profiles = (PlayerProfile.all).sample(4); #until the code above is fixed I need this to test, fix when possible - Michael
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def settings
    @user = current_user
    render 'settings'
  end
  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      session[:remember_me] == '1' ? remember(@user) : forget(@user)
      @tutorial = true if params[:help] == "yes"
      if params[:player] == "yes" ? @profile_type = "player_profiles" : @profile_type = "dm_profiles"
        respond_to do |format|
          format.html { redirect_to "/users/#{@user.id}/#{@profile_type}/new?tutorial=#{@tutorial}"}
        end
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to('/unauthorized') unless current_user?(@user)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :string, :email, :password, :password_confirmation, :profile_pic_path, :age, :last_active, :address, :max_distance, :avatar)
    end

    def logged_in_user
      unless logged_in?
        store_location
        redirect_to login_url, notice: "Please Log In"
      end
    end

    def admin_user
      redirect_to('/unauthorized') unless current_user.admin?
    end
end
