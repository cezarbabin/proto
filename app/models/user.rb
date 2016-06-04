class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first, :last, :email, presence: true
  validates :first, :last, length: {maximum: 10}
  validates :email, length: {maximum: 255},
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false },
                    :reduce => true
  has_secure_password
  validates :password, length: { minimum: 6 }, presence: true, :reduce => true

end
