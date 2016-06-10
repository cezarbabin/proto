class RemoveCreatedAtFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :post_created_at
  end
end
