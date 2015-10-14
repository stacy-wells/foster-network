class AlterAnimals < ActiveRecord::Migration
  def change
    add_column :animals, :shelter_id, :string
    add_column :animals, :animal, :string, null: false, default: "Dog"
    add_column :animals, :sex, :string, null: false
    add_column :animals, :photo, :string
    add_column :animals, :status, :string
  end
end
