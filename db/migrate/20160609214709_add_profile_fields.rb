class AddProfileFields < ActiveRecord::Migration
  def change
    add_column :profiles, :education, :text
    add_column :profiles, :expertise, :text
    add_column :profiles, :skills,    :text
    add_column :profiles, :interests, :text
  end
end
