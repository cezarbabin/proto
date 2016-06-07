class Prospect < ActiveRecord::Base
  attr_accessor :description
  before_create :create_pcode
  before_save { self.email = email.downcase }
  before_create :handle_duplicates

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true
  validates :recommender_id, presence:true
  validates :description, length: {minimum: 3}, :reduce => true
  validates :email, length: {maximum: 255},
            format: { with: VALID_EMAIL_REGEX },
            :reduce => true

  validate :havent_recommended
  validate :recommender_exists
  validate :cant_recommend_yourself

  private
    # Returns a random token.
    def Prospect.new_token
      SecureRandom.urlsafe_base64
    end

    def create_pcode
      self.pcode  = Prospect.new_token
      #self.description = "Maybenot";
    end

    def recommender_exists
      errors.add(:recommender_id, "is invalid") unless User.exists?(recommender_id)
    end

    def cant_recommend_yourself
      if (User.find(recommender_id).email == email)
        errors.add(:email, "cant recommend yaself ya prick")
        #errors.add(:recommended_id, "recommended and recommender can't be equal")
      end
      # add an appropriate error message here...
    end

    def havent_recommended
      if (!Prospect.where(recommender_id: recommender_id, email:email).empty?)
        errors.add(:email, "already recommended this once")
      end
    end

    def handle_duplicates
      existing_prospect = Prospect.find_by(email:email)
      if (!!existing_prospect)
        self.actual_id = existing_prospect.actual_id
      else
        self.actual_id = 0
        if Prospect.exists?
          self.actual_id = Prospect.last.id
        end
      end

    end

end
