class FriendsController < ApplicationController
  before_action :logged_in_user, only: [:show, :index, :edit, :update, :new]
  before_action :correct_user,   only: [:show, :edit, :update]

  def new
    @friend = Friend.new
    @left = 5 - Prospect.all.where(recommender_id:current_user.id).count -
        Relationship.all.where(recommender_id:current_user.id).count
  end

  def create
    @left = 5 - Prospect.all.where(recommender_id:current_user.id).count -
        Relationship.all.where(recommender_id:current_user.id).count

    filtered_params = friend_params
    email =       filtered_params[:email]
    description = filtered_params[:description]
    first =       filtered_params[:first_name]
    last =        filtered_params[:lastName]
    user_exists = User.find_by(email:email)

    @friend = Friend.new(recommender_id:current_user.id, description:description, email:email, firstName:first, lastName:last)

    if @friend.valid?

      if (!!user_exists)
        relationship = current_user.active_relationships.new(recommended_id:user_exists.id, description:description)
        @referral = relationship
      else
        prospect = current_user.prospect_invitations.new(email:email, description:description, firstName:first, lastName:last)
        @referral = prospect
      end

      if (@referral.save)
        flash[:info] = 'Successfully submitted candidate'
        redirect_to new_friend_path
      else
        flash.now[:danger] = "Something went wrong"
        render 'new'
      end

    else

      @friend.errors.each do |attribute, message|

      end

      render 'new'
    end

  end

  private
  def logged_in_user
    unless logged_in?
      store_location #right before redirecting to log_in
      #flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def friend_params
    params.require(:friend).permit(
        :email,
        :description,
        :first_name,
        :lastName)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end




end

