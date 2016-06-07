class UsersController < ApplicationController
  #before_action :logged_in_user, only: [:show, :index, :edit, :update]
  before_action :correct_user,   only: [:show, :edit, :update]

  def index
    @length = User.all.length
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @z = 7
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      @user.send_activation_email
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
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:first, :last, :email, :password)
    end

    # Confirms that it is the right user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

end
