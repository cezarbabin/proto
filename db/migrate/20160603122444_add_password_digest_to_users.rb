class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :relationships, :prospect, :s
  end
end
