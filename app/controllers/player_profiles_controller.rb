class PlayerProfilesController < ApplicationController
  before_action :set_player_profile, only: [:show, :edit, :update, :destroy]

  # GET /player_profiles
  # GET /player_profiles.json
  def index
    @player_profiles = PlayerProfile.all
  end

  # GET /player_profiles/1
  # GET /player_profiles/1.json
  def show
  end

  # GET /player_profiles/new
  def new
    @player_profile = PlayerProfile.new
  end

  # GET /player_profiles/1/edit
  def edit
  end

  # POST /player_profiles
  # POST /player_profiles.json
  def create
    @player_profile = PlayerProfile.new(player_profile_params)

    respond_to do |format|
      if @player_profile.save
        format.html { redirect_to @player_profile, notice: 'Player profile was successfully created.' }
        format.json { render :show, status: :created, location: @player_profile }
      else
        format.html { render :new }
        format.json { render json: @player_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_profiles/1
  # PATCH/PUT /player_profiles/1.json
  def update
    respond_to do |format|
      if @player_profile.update(player_profile_params)
        format.html { redirect_to @player_profile, notice: 'Player profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @player_profile }
      else
        format.html { render :edit }
        format.json { render json: @player_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_profiles/1
  # DELETE /player_profiles/1.json
  def destroy
    @player_profile.destroy
    respond_to do |format|
      format.html { redirect_to player_profiles_url, notice: 'Player profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_profile
      @player_profile = PlayerProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_profile_params
      params.require(:player_profile).permit(:bio, :exp_level, :ruleset1, :ruleset2, :ruleset3, :ruleset4, :user_id)
    end
end
