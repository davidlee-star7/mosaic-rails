class AddDescriptionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :description, :string
    add_column :users, :client_logo, :string
  end
end
