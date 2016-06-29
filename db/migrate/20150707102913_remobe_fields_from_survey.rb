class RemobeFieldsFromSurvey < ActiveRecord::Migration
  def change
  	remove_column :surveys, :page_title
  	remove_column :surveys, :page_description
  end
end
