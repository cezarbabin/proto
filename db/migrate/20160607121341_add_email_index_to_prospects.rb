class AddEmailIndexToProspects < ActiveRecord::Migration
  def change
    add_index :prospects, :email
    add_index :prospects, :actual_id
  end
end
