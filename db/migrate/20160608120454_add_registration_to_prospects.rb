class AddRegistrationToProspects < ActiveRecord::Migration
  def change
    add_column :prospects, :registered, :boolean, :default => false
    add_column :prospects, :registered_at, :datetime
  end
end
