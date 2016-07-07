class AddExtraValueFieldsToGroupsVariables < ActiveRecord::Migration
  def up
    add_attachment :groups_variables, :value_image
    add_attachment :groups_variables, :value_file
  end

  def down
  	remove_attachment :groups_variables, :value_image
    remove_attachment :groups_variables, :value_file
  end
end
