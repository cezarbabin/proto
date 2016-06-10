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
      @profile = Profile.create(user_id:@user.id)

      ## Transfer all prospects to relationships


      flash.now[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.

      flash.now[:info] = "Succesfully updated your profile"
      render 'edit'
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:first, :last, :email, :password, :password_confirmation)
    end

    # Confirms that it is the right user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

end
