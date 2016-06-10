class AddFields < ActiveRecord::Migration
  def change
    add_column :posts, :is_approved, :boolean, :default => false
    add_column :prospects, :firstName, :string
    add_column :prospects, :lastName, :string
  end
end
