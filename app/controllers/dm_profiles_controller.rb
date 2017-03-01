class DmProfilesController < ApplicationController
  before_action :set_dm_profile, only: [:show, :edit, :update, :destroy]

  # GET /dm_profiles
  # GET /dm_profiles.json
  def index
    @dm_profiles = DmProfile.all
  end

  # GET /dm_profiles/1
  # GET /dm_profiles/1.json
  def show
  end

  # GET /dm_profiles/new
  def new
    @dm_profile = DmProfile.new
  end

  # GET /dm_profiles/1/edit
  def edit
  end

  # POST /dm_profiles
  # POST /dm_profiles.json
  def create
    @dm_profile = DmProfile.new(dm_profile_params)
    respond_to do |format|
      if @dm_profile.save
        format.html { redirect_to @dm_profile, notice: 'Dm profile was successfully created.' }
        format.json { render :show, status: :created, location: @dm_profile }
      else
        format.html { render :new }
        format.json { render json: @dm_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dm_profiles/1
  # PATCH/PUT /dm_profiles/1.json
  def update
    respond_to do |format|
      if @dm_profile.update(dm_profile_params)
        format.html { redirect_to @dm_profile, notice: 'Dm profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @dm_profile }
      else
        format.html { render :edit }
        format.json { render json: @dm_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dm_profiles/1
  # DELETE /dm_profiles/1.json
  def destroy
    @dm_profile.destroy
    respond_to do |format|
      format.html { redirect_to dm_profiles_url, notice: 'Dm profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dm_profile
      @dm_profile = DmProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dm_profile_params
      params.require(:dm_profile).permit(:bio, :exp_level, :ruleset1, :ruleset2, :ruleset3, :ruleset4, :user_id)
    end
end
