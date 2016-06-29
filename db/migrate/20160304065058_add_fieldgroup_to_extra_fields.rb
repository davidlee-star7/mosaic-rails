class AddFieldgroupToExtraFields < ActiveRecord::Migration
  def change
    add_column :extra_fields, :field_group, :string
  end
end
