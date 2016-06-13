class ProfilesController < ApplicationController

  before_action :logged_in_user, only: [:show, :index, :edit, :update]
  before_action :correct_user,   only: [:show, :edit, :update]

  def edit
    @nr_of_people = Relationship.where(recommended_id: current_user.id).count

    user = User.find(params[:id])
    @profile = Profile.find_by(user_id: user.id)
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
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end



end
