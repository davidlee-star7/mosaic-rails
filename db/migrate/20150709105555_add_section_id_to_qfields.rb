class AddSectionIdToQfields < ActiveRecord::Migration
  def change
  	add_column :qfields, :section_id, :integer
  end
end
