class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :recommender_id
      t.integer :recommended_id

      t.timestamps null: false
    end
    add_index :relationships, :recommender_id
    add_index :relationships, :recommended_id
    add_index :relationships, [:recommender_id, :recommended_id], :unique => true
  end
end
