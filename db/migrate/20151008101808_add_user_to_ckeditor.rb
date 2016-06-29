class AddUserToCkeditor < ActiveRecord::Migration
 def change
    add_column :ckeditor_assets, :user_id, :integer
  end
end
