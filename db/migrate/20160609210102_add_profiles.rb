class AddProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :user_profile, :text
    add_column :profiles, :user_id, :integer
    add_index :profiles, :user_id
  end
end
