class ProfilesController < ApplicationController

  def edit
    @profile = Profile.new
  end

end
