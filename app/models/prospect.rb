class Prospect < ActiveRecord::Base
  before_create :create_pcode
  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true
  validates :recommender_id, presence:true
  #validates :description, length: {maximum: 500, minimum: 100}
  validates :email, length: {maximum: 255},
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false },
            :reduce => true

  validate :user_exists

  private
    # Returns a random token.
    def Prospect.new_token
      SecureRandom.urlsafe_base64
    end

    def create_pcode
      self.pcode  = Prospect.new_token
      #self.description = "Maybenot";
    end

    def user_exists
      errors.add(:recommender_id, "is invalid") unless User.exists?(recommender_id)
    end

end
