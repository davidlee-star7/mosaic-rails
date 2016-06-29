class AddMoreFieldsToSurvey < ActiveRecord::Migration
  def change
  	add_column :surveys, :page_title, :string
  	add_column :surveys, :page_description, :text
    add_column :surveys, :thank_page_title, :string
    add_column :surveys, :thank_page_description, :text
  end
end
