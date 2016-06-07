class RelationshipsController < ApplicationController
  def new
    @relationship = Relationship.new
   # @z = 7
  end

  def show

  end

  def create
    ##### NEED TO ESCAPE
    @relationship = Relationship.new
    temporary = current_user.prospect_invitations.create(email:params[:relationship][:email])
    @relationship = current_user.active_relationships.new(recommended_id:temporary.id, description:params[:relationship][:description], prospect: true)
    #@relationship = Relationship.new(recommender_id:params[:relationship][:], recommended_id:current_user.id, prospect:true, description:params[:relationship][:description])
    if @relationship.save
      render 'show'
    else
      render 'new'
    end
  end

  def edit
  end

  def update

  end

  # Follows a user.
  def recommend(other_user)
    active_relationships.create(recommended_id: other_user.id)
  end

  # Returns true if the current user is following the other user.
  def recommending?(other_user)
    recommending.include?(other_user)
  end

end
