class AddTableauUserFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tableau_user_id, :integer
    add_foreign_key :users, :tableau_users
  end
end
