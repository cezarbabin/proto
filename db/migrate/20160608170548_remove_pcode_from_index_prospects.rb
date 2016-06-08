class RemovePcodeFromIndexProspects < ActiveRecord::Migration
  def change
    remove_index :prospects, :pcode
  end
end
