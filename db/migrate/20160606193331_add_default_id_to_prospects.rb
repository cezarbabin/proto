class AddDefaultIdToProspects < ActiveRecord::Migration
  def change
    change_column :prospects, :actual_id, :integer, default: 0
  end
end
