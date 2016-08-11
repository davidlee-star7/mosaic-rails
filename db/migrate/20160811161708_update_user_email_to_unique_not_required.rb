class UpdateUserEmailToUniqueNotRequired < ActiveRecord::Migration
  def up
    change_column :users, :email, :string, null: true
    remove_index :users, :email
  end

  def down
  	change_column :users, :email, :string, null: false
  	add_index :users, :email, unique: true
  end
end
