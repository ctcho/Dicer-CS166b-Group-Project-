module SessionsHelper

  # Logs in a given user
  def log_in(user)
    session[:user_id] = user.id
    cookies.signed[:user_id] = user.id
  end

  # creates a cookie so a user's logged in session will persist
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # returns the current user, if any
  def current_user
    if (user_id = session[:user_id])
      cookies.signed[:user_id] = user_id
      @current_user ||=User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # checks if a given user is the current user
  def current_user? (user)
    user == current_user
  end

  # returns true if the user is logged in, false otherwise
  def logged_in?
    !current_user.nil?
  end

  # forgets a user, ends their sessions
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # logs a user out
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # continues a browsing session interrupted by a login or other redirect
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # stores intended destination to session
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

end
