class ProspectsController < ApplicationController

  def new
    @prospect = Prospect.new

  end

  def create
    @database_size = current_user.active_relationships.length
    @prospect = Prospect.new(prospect_params)    # Not the final implementation!
    if @prospect.save
      #UserMailer.account_activation(@user).deliver_now
      #flash[:info] = "Please check your email to activate your account."
      #redirect_to root_url
      render 'new'
    else
      render 'new'
    end
  end

  def show
    @nr = 5;
  end

  private
    def prospect_params
      params.require(:prospect).permit(:email, :description)
    end

end
