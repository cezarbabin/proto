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
    email =       params[:relationship][:email]
    description = params[:relationship][:description]


    prospect = Prospect.find_by(email:email)
    if (!!prospect)
      id = prospect.actual_id
      temporary = current_user.prospect_invitations.new(email:email, actual_id:id)
    else
      id = 0
      if (Prospect.exists?)
        id = Prospect.last.id
      end
      temporary = current_user.prospect_invitations.new(email:email, actual_id:id)
    end

    if temporary.save

      @relationship = current_user.active_relationships.new(recommended_id:temporary.actual_id, description:description, prospect: true)

      if @relationship.save
        render 'show'
      else
        Prospect.find(temporary.id).destroy
        render 'new'
      end
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
