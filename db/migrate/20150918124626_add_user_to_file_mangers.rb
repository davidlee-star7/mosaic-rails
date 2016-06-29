class AddUserToFileMangers < ActiveRecord::Migration
  def change
    add_reference :file_mangers, :user, index: true
    add_foreign_key :file_mangers, :users
  end
end
