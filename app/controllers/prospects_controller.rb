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

    # If the user is new then create a prospect
    @user = current_user.prospect_invitations.new(email:email)
    @user.description = description

    is_not_a_prospect = User.find_by(email:email)
    if (!is_not_a_prospect)
      prospect = true
      id = @user.actual_id
    else
      prospect = false
      id = is_not_a_prospect.id
    end

    if @user.save

      @relationship = current_user.active_relationships.new(
          recommended_id: id,
          description:    description,
          prospect:       prospect)

      #HACK
      if !!is_not_a_prospect
        @user.destroy
      end

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
