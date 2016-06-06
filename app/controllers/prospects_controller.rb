class ProspectsController < ApplicationController

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      log_in @user
      #UserMailer.account_activation(@user).deliver_now
      #flash[:info] = "Please check your email to activate your account."
      #redirect_to root_url
      render 'show'
    else
      render 'new'
    end
  end

end
