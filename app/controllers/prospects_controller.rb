class ProspectsController < ApplicationController

  def new
    @prospect = Prospect.new
  end

  def show
  end

  def create
    @prospect = Prospect.new

    ##### NEED TO ESCAPE
    email =       params[:prospect][:email]
    description = params[:prospect][:description]

    @prospect = current_user.prospect_invitations.new(email:email)
    @prospect.description = description

    if @prospect.save
      @relationship = current_user.active_relationships.new(recommended_id:@prospect.actual_id, description:description, prospect: true)

      if @relationship.save
        render 'new'
      else
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
