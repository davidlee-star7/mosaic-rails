class AddUniqueIndexForUserIdGroupIdInUsersGroups < ActiveRecord::Migration
  def change
  	add_index :users_groups, [:group_id, :user_id], :unique => true
  end
end
