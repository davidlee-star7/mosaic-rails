class AddFieldstotablesa < ActiveRecord::Migration
  def change
  	add_column :tableaus, :project_name, :string
  	add_column :tableaus, :project_title, :string
  end
end
