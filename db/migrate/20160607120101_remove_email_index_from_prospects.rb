class RemoveEmailIndexFromProspects < ActiveRecord::Migration
  def change
    remove_index :prospects, :email
  end
end
