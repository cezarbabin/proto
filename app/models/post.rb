class Post < ActiveRecord::Base
  belongs_to :user
  validate :has_not_exceeded_limit

  def has_not_exceeded_limit
    if (User.find(user_id).post_id != nil)
      errors.add(:text, "You reached the limit for the week")
    end
  end

  private



end
