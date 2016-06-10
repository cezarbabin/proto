class AddPostCreatedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :post_created_at, :datetime
  end
end
