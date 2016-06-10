class ProfilesController < ApplicationController

  def edit
    user = User.find(params[:id])
    @profile = Profile.find_by(user_id: user.id)
  end

  def update
    @profile = Profile.find_by(id: params[:id])

    if @profile.update_attributes(profile_params)
      flash.now[:info] = "Succesfully updated your profile"
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

end
