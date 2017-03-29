class SessionsController < ApplicationController

  # Get /login
  def new
    if logged_in?
      render 'already_logged_in'
    else
      render 'new'
    end
  end

  # POST /login
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user  && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  # DELETE /logout
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
