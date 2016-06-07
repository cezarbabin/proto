class Relationship < ActiveRecord::Base
  attr_accessor :email
  validates_associated :recommender

  belongs_to :recommender, class_name: "User"
  belongs_to :recommended, class_name: "User"

  #validates :recommender_id, presence: true
  #validates :recommended_id, presence: true

  #validates :recommender_id, uniqueness: { scope: :recommended_id }

  #validates :description, length: {maximum: 500, minimum: 100}
  #validates :description, length: {minimum: 3}

  validate :cant_recommend_yourself


  def cant_recommend_yourself
    if (recommender_id == recommended_id && !prospect)
      errors.add(:recommended_id, "recommended and recommender can't be equal")
      errors.add(:recommended_id, "recommended and recommender can't be equal")
    end
    # add an appropriate error message here...
  end


end
