class SessionsController < ApplicationController
  before_action :logged_out_user, only: [:create, :index, :edit, :new]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        redirect_back_or new_submit_path
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to login_url
      end
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_url
  end

  def logged_out_user
    if logged_in?
      redirect_to root_url
    end
  end
end
