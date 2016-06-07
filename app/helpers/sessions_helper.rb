module SessionsHelper

  # Is there a user currently logged in?
  def logged_in_user
    unless logged_in?
      store_location #right before redirecting to log_in
      #flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns true if the CURRENT user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Returns the current logged-in user (if any), defined by the session id
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

end
