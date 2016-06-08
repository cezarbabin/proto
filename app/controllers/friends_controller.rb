class FriendsController < ApplicationController
  before_action :logged_in_user, only: [:show, :index, :edit, :update, :new]

  def new
  end

  def create
    ##### NEED TO ESCAPE
    #@user = User.new
    #current_user = User.find_by(id: session[:user_id])

    email =       params[:friend][:email]
    description = params[:friend][:description]
    user_exists = User.find_by(email:email)

    if (!!user_exists)
      relationship = current_user.active_relationships.new(recommended_id:user_exists.id, description:description)
      @referral = relationship
    else
      prospect = current_user.prospect_invitations.new(email:email, description:description)
      @referral = prospect
    end

    nr_of_referrals = Prospect.all.where(recommender_id:current_user.id).count +
                        Relationship.all.where(recommender_id:current_user.id).count

    if (nr_of_referrals < 5)

      #@relationship = current_user.active_relationships.new(
          #recommended_id: id,
          #description:    description,
          #prospect:       prospect)

      #HACK
      #if !!is_not_a_prospect
        #@user.destroy
      #end
      if (@referral.save)
        flash.now[:info] = 'Successfully submitted candidate'
        render 'new'
      else
        flash.now[:error] = "Something went wrong"
        render 'new'
      end
    else
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



end

