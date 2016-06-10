class Relationship < ActiveRecord::Base
  attr_accessor :email
  validates_associated :recommender

  belongs_to :recommender, class_name: "User"
  belongs_to :recommended, class_name: "User"

  validates :recommender_id, presence: true
  validates :recommended_id, presence: true

  validates :recommender_id, uniqueness: { scope: :recommended_id, message: "You have already recommended this person once" }

  validate :cant_recommend_yourself
  validate :nr_of_referrals
  #validates :description, length: {maximum: 500, minimum: 100}
  validate :description_length

  serialize :attributes_hash, Hash

  private

    def description_length
      if (description.length < 4)
        errors.add(:description, 'too short ma man')
      end
    end


    def cant_recommend_yourself
      if (recommender_id == recommended_id)
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
