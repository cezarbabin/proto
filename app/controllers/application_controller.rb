class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  # will involved defining a large number of related functions for use
  # across multiple controllers and views




  before_filter :logged_in_user, only: [ :show, :index, :edit, :update]
  private
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location #right before redirecting to log_in
        #flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
