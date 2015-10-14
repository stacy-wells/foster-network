class DeleteFromAnimals < ActiveRecord::Migration
  def change
    remove_column :animals, :species, :string, null: false
    remove_column :animals, :gender, :string
    remove_column :animals, :size, :string
    remove_column :animals, :fixed, :boolean
    remove_column :animals, :kid_friendly, :boolean
  end
end
