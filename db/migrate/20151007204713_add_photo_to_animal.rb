class AddPhotoToAnimal < ActiveRecord::Migration
  def change
    add_column :animals, :animal_photo, :string
  end
end
