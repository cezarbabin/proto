class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.string :name
      t.string :directory

      t.timestamps null: false
    end
    add_index :universities, :name, :unique => true
  end
end
