class AddSubmittedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :submitted, :boolean, :default => false
  end
end
