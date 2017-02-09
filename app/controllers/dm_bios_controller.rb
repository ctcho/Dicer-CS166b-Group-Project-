class DmBiosController < ApplicationController
  before_action :set_dm_bio, only: [:show, :edit, :update, :destroy]

  # GET /dm_bios
  # GET /dm_bios.json
  def index
    @dm_bios = DmBio.all
  end

  # GET /dm_bios/1
  # GET /dm_bios/1.json
  def show
  end

  # GET /dm_bios/new
  def new
    @dm_bio = DmBio.new
  end

  # GET /dm_bios/1/edit
  def edit
  end

  # POST /dm_bios
  # POST /dm_bios.json
  def create
    @dm_bio = DmBio.new(dm_bio_params)

    respond_to do |format|
      if @dm_bio.save
        format.html { redirect_to @dm_bio, notice: 'Dm bio was successfully created.' }
        format.json { render :show, status: :created, location: @dm_bio }
      else
        format.html { render :new }
        format.json { render json: @dm_bio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dm_bios/1
  # PATCH/PUT /dm_bios/1.json
  def update
    respond_to do |format|
      if @dm_bio.update(dm_bio_params)
        format.html { redirect_to @dm_bio, notice: 'Dm bio was successfully updated.' }
        format.json { render :show, status: :ok, location: @dm_bio }
      else
        format.html { render :edit }
        format.json { render json: @dm_bio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dm_bios/1
  # DELETE /dm_bios/1.json
  def destroy
    @dm_bio.destroy
    respond_to do |format|
      format.html { redirect_to dm_bios_url, notice: 'Dm bio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dm_bio
      @dm_bio = DmBio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dm_bio_params
      params.require(:dm_bio).permit(:bio, :exp_level, :ruleset1, :ruleset2, :ruleset3, :ruleset4)
    end
end
