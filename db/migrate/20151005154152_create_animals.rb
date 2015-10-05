class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
      t.string :name, null: false
      t.integer :animal_rescue_id, null: false
      t.integer :fostered_by_id

      t.timestamps
    end
  end
end
