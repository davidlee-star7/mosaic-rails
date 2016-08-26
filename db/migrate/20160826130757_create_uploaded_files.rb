class CreateUploadedFiles < ActiveRecord::Migration
  def change
    create_table :uploaded_files do |t|
      t.timestamps null: false
    end
    add_attachment :uploaded_files, :file
  end
end
