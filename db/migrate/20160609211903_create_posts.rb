class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.text :post
      t.datetime :post_created_at

      t.timestamps null: false
    end
    add_index :posts, :user_id
  end

end
