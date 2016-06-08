class AddEmailSentToProspects < ActiveRecord::Migration
  def change
    add_column :prospects, :email_sent, :datetime
  end
end
