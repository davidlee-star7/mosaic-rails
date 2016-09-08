class AddUserIdToUploadedFiles < ActiveRecord::Migration
  def change
  	add_column :uploaded_files, :user_id, :integer
    add_foreign_key :uploaded_files, :users
  end
end
