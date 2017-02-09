class PlayerBiosController < ApplicationController
  before_action :set_player_bio, only: [:show, :edit, :update, :destroy]

  # GET /player_bios
  # GET /player_bios.json
  def index
    @player_bios = PlayerBio.all
  end

  # GET /player_bios/1
  # GET /player_bios/1.json
  def show
  end

  # GET /player_bios/new
  def new
    @player_bio = PlayerBio.new
  end

  # GET /player_bios/1/edit
  def edit
  end

  # POST /player_bios
  # POST /player_bios.json
  def create
    @player_bio = PlayerBio.new(player_bio_params)

    respond_to do |format|
      if @player_bio.save
        format.html { redirect_to @player_bio, notice: 'Player bio was successfully created.' }
        format.json { render :show, status: :created, location: @player_bio }
      else
        format.html { render :new }
        format.json { render json: @player_bio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_bios/1
  # PATCH/PUT /player_bios/1.json
  def update
    respond_to do |format|
      if @player_bio.update(player_bio_params)
        format.html { redirect_to @player_bio, notice: 'Player bio was successfully updated.' }
        format.json { render :show, status: :ok, location: @player_bio }
      else
        format.html { render :edit }
        format.json { render json: @player_bio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_bios/1
  # DELETE /player_bios/1.json
  def destroy
    @player_bio.destroy
    respond_to do |format|
      format.html { redirect_to player_bios_url, notice: 'Player bio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_bio
      @player_bio = PlayerBio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_bio_params
      params.require(:player_bio).permit(:bio, :exp_level, :ruleset1, :ruleset2, :ruleset3, :ruleset4)
    end
end
