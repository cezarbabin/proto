class RenamePostContent < ActiveRecord::Migration
  def change
    rename_column :posts, :post, :text
  end
end
