class AddAdtionalFieldstoQuestion < ActiveRecord::Migration
  def change
  	add_column :questions, :default_answer, :integer
  	add_column :questions, :weight, :integer
  	add_column :questions, :additional_instruction_text, :text
  	add_column :questions, :allow_comments, :boolean
  end
end
