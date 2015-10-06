class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
      t.string :name, null: false
      t.string :species, null: false
      t.string :gender
      t.string :age
      t.string :size
      t.string :description
      t.boolean :fixed
      t.boolean :dog_friendly
      t.boolean :cat_friendly
      t.boolean :kid_friendly
      t.integer :animal_rescue_id, null: false
      t.integer :fostered_by_id

      t.timestamps
    end
  end
end
