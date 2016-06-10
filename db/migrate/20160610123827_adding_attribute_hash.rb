class AddingAttributeHash < ActiveRecord::Migration
  def change
    add_column :relationships, :attributes_hash, :text
    add_column :prospects, :attributes_hash, :text
  end
end
