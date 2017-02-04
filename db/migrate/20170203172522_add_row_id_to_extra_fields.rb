class AddRowIdToExtraFields < ActiveRecord::Migration
  def change
    add_column :extra_fields, :extra_row_id, :integer
    add_foreign_key :extra_fields, :extra_rows
  end
end
