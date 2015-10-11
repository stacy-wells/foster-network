class AddHomeEnvironmentUser < ActiveRecord::Migration
  def change
    add_column :users, :has_dogs, :boolean
    add_column :users, :has_cats, :boolean
    add_column :users, :has_kids, :boolean
  end
end
