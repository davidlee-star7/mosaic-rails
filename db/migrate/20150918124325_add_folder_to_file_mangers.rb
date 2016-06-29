class AddFolderToFileMangers < ActiveRecord::Migration
  def change
    add_reference :file_mangers, :folder, index: true
    add_foreign_key :file_mangers, :folders
  end
end
