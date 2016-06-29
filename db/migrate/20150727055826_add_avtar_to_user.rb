class AddAvtarToUser < ActiveRecord::Migration
  def change
  	add_column :users, :avatar, :string
  	remove_column :users, :user_image
  end
end
