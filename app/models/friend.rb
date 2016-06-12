class Friend
  include ActiveModel::Model

  attr_accessor :recommender_id
  attr_accessor :email, :first_name, :lastName
  attr_accessor :description

  #has_many :active_relationships, class_name:  "Relationship",
  #         foreign_key: "recommender_id"

  #has_many :prospect_invitations, class_name: "Prospect",
  #         foreign_key: "recommender_id"

  validates :first_name, :lastName, :email, :description, presence:true


  validate :relationship_exists
  validate :prospect_exists
  validate :cant_recommend_yourself
  validate :nr_of_referrals


  def persisted?
    false
  end

  def relationship_exists
    recommended_user = User.find_by(email:email)
    if (recommended_user != nil)
      if (Relationship.find_by(recommender_id:recommender_id, recommended_id:recommended_user.id)!=nil)
        errors.add(:email, "already recommended this email")
      end
    end
  end

  def prospect_exists
    if(Prospect.find_by(recommender_id:recommender_id, email:email)!= nil)
      errors.add(:email, "already recommended this email")
    end
  end

  def cant_recommend_yourself
    if (User.find(recommender_id).email == email)
      errors.add(:email, "cant recommend yaself ya prick")
      #errors.add(:recommended_id, "recommended and recommender can't be equal")
    end
    # add an appropriate error message here...
  end

  def nr_of_referrals
    nr_of_referrals = Prospect.all.where(recommender_id:recommender_id).count +
        Relationship.all.where(recommender_id:recommender_id).count
    if (nr_of_referrals >= 5 && !User.find(recommender_id).admin)
      errors.add(:email, 'you have exceeded the limit of referrals')
    end
  end

end
