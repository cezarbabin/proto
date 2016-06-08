class AddPcodeValidityToProspects < ActiveRecord::Migration
  def change
    add_column :prospects, :pcode_is_valid, :boolean, :default => true
  end
end
