class AddIndexToProspects < ActiveRecord::Migration
  def change
    add_index :prospects, :email, unique: true
    add_index :prospects, :pcode, unique: true
  end
end
