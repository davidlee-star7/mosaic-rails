class AddExtraValueFieldsToUsersVariables < ActiveRecord::Migration
  def up
    add_attachment :users_variables, :value_image
    add_attachment :users_variables, :value_file
  end

  def down
  	remove_attachment :users_variables, :value_image
    remove_attachment :users_variables, :value_file
  end
end
