class CreateFosterOffers < ActiveRecord::Migration
  def change
    create_table :foster_offers do |t|
      t.belongs_to :user
      t.belongs_to :animal
      t.integer :animal_rescue_id

      t.timestamps
    end
  end
end
