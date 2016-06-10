class Post < ActiveRecord::Base
  belongs_to :user
  before_destroy :delete_user_post_id

  validates :title, :text, :presence => true

  validate :has_not_exceeded_limit


  def has_not_exceeded_limit
    if (User.find(user_id).post_id != nil)
      errors.add(:text, "You reached the limit for the week")
    end
  end

  def delete_user_post_id
    User.find(user_id).update_attributes(post_id: nil)
  end

  private



end
