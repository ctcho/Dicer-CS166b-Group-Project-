class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
        # format.html { redirect_to @user, notice: "Welcome to Dicer" }
        # format.json { render :show, status: :created, location: @user }
      if params[:help]
        if params[:player] == "yes"
          respond_to do |format|
            format.html { redirect_to "/users/#{@user.id}/player_profiles  /new/crashcourse" }
            #redirect_to "/user/#{@user.id}/player_profile/new/crashcourse"
            end
          else
            # new dm profile, guided
          end
        else
            if params[:player_profile] || 1==1
              respond_to do |format|
                format.html{ redirect_to new_user_player_profiles_path(@user) }
              end
            else
              # new dm_profile, undguided
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :string, :email, :password, :password_confirmation, :profile_pic_path, :age, :last_active, :address)
    end
end
