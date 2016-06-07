class AddDescriptionToRelationships < ActiveRecord::Migration

  def change
    add_column :relationships, :description, :text
    remove_column :prospects, :description
  end


end
