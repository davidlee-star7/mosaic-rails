class AddUserToFolders < ActiveRecord::Migration
  def change
    add_reference :folders, :user, index: true
    add_foreign_key :folders, :users
  end
end
