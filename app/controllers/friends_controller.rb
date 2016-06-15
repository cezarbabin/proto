class FriendsController < ApplicationController
  before_action :logged_in_user, only: [:show, :index, :edit, :update, :new]
  before_action :correct_user,   only: [:show, :edit, :update]
  before_action :not_submitted

  def new
    @friend = Friend.new
    @left = 5 - Prospect.all.where(recommender_id:current_user.id).count -
        Relationship.all.where(recommender_id:current_user.id).count
    @here = get_directory
  end

  def create
    @left = 5 - Prospect.all.where(recommender_id:current_user.id).count -
        Relationship.all.where(recommender_id:current_user.id).count

    filtered_params = friend_params
    email =       filtered_params[:email]
    description = filtered_params[:description]
    first =       filtered_params[:first_name]
    last =        filtered_params[:last_name]
    user_exists = User.find_by(email:email)

    @friend = Friend.new(recommender_id:current_user.id, description:description, email:email, first_name:first, last_name:last)

    if @friend.valid?

      if (!!user_exists)
        relationship = current_user.active_relationships.new(recommended_id:user_exists.id, description:description)
        @referral = relationship
      else
        prospect = current_user.prospect_invitations.new(email:email, description:description, firstName:first, lastName:last)
        @referral = prospect
      end

      if (@referral.save)
        flash[:info] = 'Submitted successfully'
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
        :last_name)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

  def not_submitted
    if current_user.submitted
      redirect_to(root_url)
    end
  end

  def get_directory
    user_college = 'null'
    emails = University.pluck(:name)
    user_email = current_user.email
    for email_allowed in emails
      if user_email.include? email_allowed
        user_college = email_allowed
      end
    end
    if user_college == 'null'
      here = 'http://google.com'
    else
      here = 'http://' + University.find_by(name:user_college).directory
    end
  end




end

