class CreateProspects < ActiveRecord::Migration
  def change
    create_table :prospects do |t|
      t.string :email
      t.text :description
      t.string :pcode
      t.integer :actual_id

      t.timestamps null: false
    end
  end
end
