class RemoveUserProfileFields < ActiveRecord::Migration
  def change
    remove_column :profiles, :user_profile
  end
end
