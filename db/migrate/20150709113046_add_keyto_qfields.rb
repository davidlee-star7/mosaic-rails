class AddKeytoQfields < ActiveRecord::Migration
  def change
  	add_column :qfields, :question_id, :integer
  	remove_column :qfields, :section_id
  end
end
