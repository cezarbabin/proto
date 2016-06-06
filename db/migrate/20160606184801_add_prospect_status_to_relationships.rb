class AddProspectStatusToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :prospect, :boolean, default: false
  end
end
