class AddDescriptionToProspects < ActiveRecord::Migration
  def change
    add_column :prospects, :description, :text
  end
end
