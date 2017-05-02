class DmProfilesController < ApplicationController
  include SearchPagesHelper
  before_action :set_dm_profile, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :edit, :update]
  before_action :correct_user, only: [:new, :edit, :update]
  # GET /dm_profiles
  # GET /dm_profiles.json
  def index
    @dm_profiles = DmProfile.all
  end

  # GET /user/1/dm_profiles
  # GET /user/1/dm_profiles.json
  def show
    @user = User.find(params[:user_id])
    @dm_profile = @user.dm_profile
    @similar_profiles = User.recommender(@dm_profile, "dm")
    @similar_profiles = recommend_set(@similar_profiles, @user)
    if !@dm_profile
      redirect_to new_user_dm_profiles_path(@user, tutorial: params[:tutorial])
    else
      render 'show'
    end
  end

  # GET /user/1/dm_profiles/new
  def new
    @tutorial = params[:tutorial] if params[:tutorial] == "true"
    @user = User.find(params[:user_id])
    @dm_profile = DmProfile.new
  end

  # GET user/1/dm_profiles/edit
  def edit
    @user = User.find(params[:user_id])
    @dm_profile = @user.dm_profile
  end

  # POST /user/1/dm_profiles
  # POST user/1/dm_profiles.json
  def create
    @user = User.find(params[:user_id])
    @dm_profile = DmProfile.new(dm_profile_params)
    respond_to do |format|
      if @dm_profile.save
        @user.update(dm_profile: @dm_profile)
        format.html { redirect_to user_dm_profiles_path(@user, @dm_profile), notice: 'Dm profile was successfully created.' }
        format.json { render :show, status: :created, location: @dm_profile }
      else
        @tutorial = params[:tutorial]
        format.html { render :new }
        format.json { render json: @dm_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user/1/dm_profiles
  # PATCH/PUT /user/1/dm_profiles.json
  def update
    respond_to do |format|
      if @dm_profile.update(dm_profile_params)
        format.html { redirect_to user_dm_profiles_path(User.find(@dm_profile.user_id), @dm_profile), notice: 'Dm profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @dm_profile }
      else
        format.html { render :edit }
        format.json { render json: @dm_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user/1/dm_profiles
  # DELETE /user/1/dm_profiles.json
  def destroy
    @dm_profile.destroy
    respond_to do |format|
      format.html { redirect_to user_dm_profiles_url, notice: 'Dm profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dm_profile
      @dm_profile = DmProfile.where(user_id: params[:user_id])[0]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dm_profile_params
      profile_params = params.require(:dm_profile).permit(:user_id, :bio, :experience_level, :max_distance, :online_play, :homebrew, :original_ruleset, :advanced_ruleset, :pathfinder, :third, :three_point_five, :fourth, :fifth, :original_campaign, :module)
      profile_params[:user_id] = params[:user_id]
      profile_params[:experience_level] ||= params[:experience_level]
      profile_params
    end

    def logged_in_user
      unless logged_in?
        store_location
        redirect_to login_url, notice: "Please Log In"
      end
    end

    def correct_user
      @user = User.find(params[:user_id])
      redirect_to('/unauthorized') unless current_user?(@user)
    end


end
