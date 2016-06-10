class Profile < ActiveRecord::Base
  validates :user_id, :uniqueness => true

end
