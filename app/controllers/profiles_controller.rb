class ProfilesController < ApplicationController

  before_action :logged_in_user, only: [:show, :index, :edit, :update]
  before_action :correct_user,   only: [:show, :edit, :update]
  before_action :not_submitted,  only: [:show, :index, :edit, :update]

  def edit
    @nr_of_people = Relationship.where(recommended_id: current_user.id).count

    user = User.find(params[:id])
    if Profile.exists?(user.id)
      @profile = Profile.find_by(user_id: user.id)
    end
  end

  def update
    @profile = Profile.find_by(id: params[:id])

    if @profile.update_attributes(profile_params)
      flash.now[:info] = "Successfully updated your profile"
      render 'edit'
    else
      render 'edit'
    end
  end

  private
    def profile_params
      params.require(:profile).permit(
          :education,
          :expertise,
          :interests,
          :skills)
    end

    def correct_user
      if User.exists?(params[:id])
        @user = User.find(params[:id])
        redirect_to(root_url) unless @user == current_user
      else
        redirect_to root_url
      end

    end

    def not_submitted

      if current_user.submitted
        redirect_to(root_url)
      end
    end



end
