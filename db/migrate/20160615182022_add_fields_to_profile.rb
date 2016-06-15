class AddFieldsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :industry, :text
    add_column :profiles, :company_size, :text
    add_column :profiles, :company_age, :text
    add_column :profiles, :salary, :text
    add_column :profiles, :o1, :text
    add_column :profiles, :o2, :text
    add_column :profiles, :o3, :text
    add_column :profiles, :o4, :text

  end
end
