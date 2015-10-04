class AddCustomizationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :city, :string, null: false
    add_column :users, :state, :string, null: false
    add_column :users, :phone, :string
    add_column :users, :description, :string
    add_column :users, :rescue_group, :boolean, null: false, default: false
  end
end
