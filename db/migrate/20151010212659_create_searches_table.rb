class CreateSearchesTable < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.boolean :dog_friendly
      t.boolean :cat_friendly
      t.boolean :kid_friendly
      t.string :city
      t.string :state
      t.boolean :rescue_group, default: false
      t.string :name
      t.string :email
    end
  end
end
