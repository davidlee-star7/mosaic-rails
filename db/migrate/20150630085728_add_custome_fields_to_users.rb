class AddCustomeFieldsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :username, :string
  	add_column :users, :first_name, :string
    add_column :users, :sir_name, :string
    add_column :users, :last_name, :string
    add_column :users, :display_name, :string
    add_column :users, :status, :boolean
    add_column :users, :activation_key, :string
    add_column :users, :user_image, :string
    add_column :users, :group_id, :integer
  end
end
