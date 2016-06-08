class Relationship < ActiveRecord::Base
  attr_accessor :email
  validates_associated :recommender

  belongs_to :recommender, class_name: "User"
  belongs_to :recommended, class_name: "User"

  validates :recommender_id, presence: true
  validates :recommended_id, presence: true

  #validates :recommender_id, uniqueness: { scope: :recommended_id, message: "You have already recommended this person once" }

  validate :havent_recommended
  #validates :description, length: {maximum: 500, minimum: 100}
  #validates :description, length: {minimum: 3}

  def havent_recommended
    query = Relationship.where(recommender_id: recommender_id, recommended_id: recommended_id)
    prospect_with_email = !query.empty?
    if (prospect_with_email)
      errors.add(:email, "already recommended this once") unless (query.count == 1 && query.first.prospect == prospect)
    end
  end

end
