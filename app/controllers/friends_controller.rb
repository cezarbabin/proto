class FriendsController < ApplicationController
  before_action :logged_in_user, only: [:show, :index, :edit, :update, :new]
  before_action :correct_user,   only: [:show, :edit, :update]



  def new
    @referral = Prospect.new
    @left = 5 - Prospect.all.where(recommender_id:current_user.id).count -
        Relationship.all.where(recommender_id:current_user.id).count
  end

  def create
    ##### NEED TO ESCAPE
    #@user = User.new
    #current_user = User.find_by(id: session[:user_id])

    @left = 5 - Prospect.all.where(recommender_id:current_user.id).count -
        Relationship.all.where(recommender_id:current_user.id).count

    filtered_params = friend_params
    email =       filtered_params[:email]
    description = filtered_params[:description]
    user_exists = User.find_by(email:email)

    if (!!user_exists)
      relationship = current_user.active_relationships.new(recommended_id:user_exists.id, description:description)
      @referral = relationship
    else
      prospect = current_user.prospect_invitations.new(email:email, description:description)
      @referral = prospect
    end


    #attributes_hash = {}
    #attributes_hash[friend_params[:tags1]]=friend_params[:tags2];
    #attributes_hash[friend_params[:tags3]]=friend_params[:tags4];
    #attributes_hash[friend_params[:tags5]]=friend_params[:tags6];
    #attributes_hash[friend_params[:tags7]]=friend_params[:tags8];
    #attributes_hash[friend_params[:tags9]]=friend_params[:tags10];
    #@referral.update_attributes(attributes_hash:attributes_hash)


      #@relationship = current_user.active_relationships.new(
          #recommended_id: id,
          #description:    description,
          #prospect:       prospect)

      #HACK
      #if !!is_not_a_prospect
        #@user.destroy
      #end
    if (@referral.save)
      flash[:info] = 'Successfully submitted candidate'
      #render 'new'
      redirect_to new_friend_path
    else
      flash.now[:danger] = "Something went wrong"
      render 'new'
      #redirect_to new_friend_path
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
          :tags1,
          :tags2,
          :tags3,
          :tags4,
          :tags5,
          :tags6,
          :tags7,
          :tags8,
          :tags9,
          :tags10)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end




end

