class Relationship < ActiveRecord::Base
  attr_accessor :email
  validates_associated :recommender

  belongs_to :recommender, class_name: "User"
  belongs_to :recommended, class_name: "User"

  validates :recommender_id, presence: true
  validates :recommended_id, presence: true

  validates :recommender_id, uniqueness: { scope: :recommended_id, message: "You have already recommended this person once" }

  validate :cant_recommend_yourself
  #validates :description, length: {maximum: 500, minimum: 100}
  validates :description, length: {minimum: 3}

  private
    def cant_recommend_yourself
      if (recommender_id == recommended_id)
        errors.add(:email, "cant recommend yaself ya prick")
        #errors.add(:recommended_id, "recommended and recommender can't be equal")
      end
      # add an appropriate error message here...
    end
end
