class CreateUsersGroups < ActiveRecord::Migration
  def change
    create_table :users_groups do |t|
      t.belongs_to :group, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
      t.timestamps null: false
    end
  end
end
