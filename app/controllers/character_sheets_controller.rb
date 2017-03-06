class CharacterSheetsController < ApplicationController
  before_action :set_character_sheet, only: [:show, :edit, :update, :destroy]

  # GET /character_sheets
  # GET /character_sheets.json
  def index
    @character_sheets = CharacterSheet.all
  end

  # GET /character_sheets/1
  # GET /character_sheets/1.json
  def show
    @user = User.find(params[:user_id])
    @player_profile = @user.player_profile
  end

  # GET /character_sheets/new
  def new
    #@player_profile = User.find(params[:user_id]).player_profile
    @user = User.find(params[:user_id])
    @character_sheet = CharacterSheet.new
  end

  # GET /character_sheets/1/edit
  def edit
    @user = User.find(params[:user_id])
    @character_sheet = CharacterSheet.find(params[:id])
  end

  # POST /character_sheets
  # POST /character_sheets.json
  def create
    @user = User.find(params[:user_id])
    @character_sheet = @user.player_profile.character_sheets.new(character_sheet_params)
    respond_to do |format|
      if @character_sheet.save
        format.html { redirect_to user_player_profiles_character_sheet_path(@user, @character_sheet), notice: 'Character sheet was successfully created.' }
        format.json { render :show, status: :created, location: @character_sheet }
      else
        format.html { render :new }
        format.json { render json: @character_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /character_sheets/1
  # PATCH/PUT /character_sheets/1.json
  def update
    respond_to do |format|
      if @character_sheet.update(character_sheet_params)
        format.html { redirect_to user_player_profiles_character_sheet_path(@character_sheet.player_profile.user, @character_sheet), notice: 'Character sheet was successfully updated.' }
        format.json { render :show, status: :ok, location: @character_sheet }
      else
        format.html { render :edit }
        format.json { render json: @character_sheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /character_sheets/1
  # DELETE /character_sheets/1.json
  def destroy
    @character_sheet.destroy
    respond_to do |format|
      format.html { redirect_to user_player_profiles_character_sheets_url, notice: 'Character sheet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character_sheet
      @character_sheet = CharacterSheet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def character_sheet_params
      params.require(:character_sheet).permit(:player_profile_id, :file_path)
    end
end
