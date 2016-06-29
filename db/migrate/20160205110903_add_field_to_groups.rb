class AddFieldToGroups < ActiveRecord::Migration
  def change
  	add_column :groups, :default_language, :string
  end
end
