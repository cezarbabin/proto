class User < ActiveRecord::Base
  attr_accessor :activation_token, :reset_token
  before_create :create_activation_digest
  before_save { self.email = email.downcase }
  after_save :update_profiles_table
  after_save :update_prospect_table

  validates_length_of :recommending, maximum: 4 ## NO IDEA WHY IT ONLY STOPS VALIDATION AFTER ONE

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "recommender_id"
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "recommended_id"
  has_many :prospect_invitations, class_name: "Prospect",
                                  foreign_key: "recommender_id"
  has_many :posts

  has_many :recommending, through: :active_relationships, source: :recommended
  has_many :recommenders, through: :passive_relationships, source: :recommender
  has_many :prospects, through: :prospect_invitations, source: :recommender

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i


  validates :first_name, :last_name, :email, presence: true
  validates :first_name, :last_name, length: {maximum: 50}
  validates :email, length: {maximum: 255},
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false },
                    :reduce => true

  validate :is_part_of_allowed_universities
  has_secure_password
  validates :password, length: { minimum: 8 }, presence: true, :reduce => true, allow_nil: true
  validate :has_uppercase_letters?
  validate :has_downcase_letters?
  validate :has_digits?
  #validate :check_personal_code, :on => :create

  def downcase_email
    self.email = email.downcase
  end

  def is_part_of_allowed_universities
    downcase_email
    emails = University.pluck(:name)
    user_email = email
    user_college = 'null'
    for email_allowed in emails
      if user_email.include? email_allowed
        user_college = email_allowed
      end
    end
    if user_college == 'null'
      errors.add(:email, 'is not from an eligible university ')
    end
  end


  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Generates new token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Updates the prospect table
  def update_prospect_table
    prospect = Prospect.find_by(email:email)
    if  prospect != nil
      prospect.update_attribute(:registered, true)
    end
  end

  # Creates the password digest
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends the password_reset digest
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Validates if password reset still valid
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def check_personal_code
    if (email?)
      prospect = Prospect.where(email:email.downcase).first
    end

    #puts self.pcode
    #prospect = Prospect.where(pcode:self.pcode).first
    if !prospect
      errors.add(:email, "has not been granted access to the platform.")
    end
    if !!prospect && (prospect.registered == true)
      errors.add(:email, "this email is already in use")
    end

  end

  def update_profiles_table
    @profile = Profile.create(user_id:id)
  end

  def has_uppercase_letters?
    if password != nil
      score = password.match(/[A-Z]/) ? 1 : 0
      if score == 0
        errors.add(:password, "Password needs to have uppercase letters")
      end
    end

  end

  def has_digits?
    if password != nil
      score = password.match(/\d/) ? 1 : 0
      if score == 0
        errors.add(:password, "Password needs to have digits")
      end
    end

  end

  def has_downcase_letters?
    if password != nil
      score = password.match(/[a-z]{1}/) ? 1 : 0
      if score == 0
        errors.add(:password, "Password needs to have downcase letters")
      end
    end

  end

  private
  # Returns a random token.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
