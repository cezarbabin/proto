class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :index, :edit, :update]
  before_action :correct_user,   only: [:show, :edit, :update]

  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)


    if @user.save
      @user.send_activation_email


      ## Transfer all prospects to relationships


      flash.now[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      @user.errors.each do |attribute, message|

      end

      render 'new'
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if no_prospect_with_this_email
      return_value = user_params
      return_value.delete :email
      if @user.update_attributes(return_value)
        # Handle a successful update.

        flash.now[:info] = "Succesfully updated your profile"
        render 'edit'
      else
        @user.errors.each do |attribute, message|

        end

        render 'edit'
      end
    else
      render 'edit'
    end
  end

  private
    def user_params
      return_value = params.require(:user).permit(:first, :last, :email, :password, :password_confirmation)
    end

    # Confirms that it is the right user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

    def no_prospect_with_this_email
      if (params[:user][:email] != nil)
        prospect = Prospect.where(email:params[:user][:email].downcase).count
        if (prospect != 0)
          flash.now[:danger] = "Email is taken"
          return false
        end
      end

      return true
    end

end
