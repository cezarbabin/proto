class AddPostToUsers < ActiveRecord::Migration
  def change
    add_column :users, :post_id, :integer, unique: true
  end
end
