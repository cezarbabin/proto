class AddRecommenderIdToProspects < ActiveRecord::Migration
  def change
    add_column :prospects, :recommender_id, :integer
    add_index :prospects, :recommender_id
  end
end
