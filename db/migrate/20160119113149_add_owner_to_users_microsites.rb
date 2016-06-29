class AddOwnerToUsersMicrosites < ActiveRecord::Migration
  def change
  	add_column :users_microsites, :owner, :boolean, :default => false
  end
end
