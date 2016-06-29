class CreateExtraFields < ActiveRecord::Migration
  def change
    create_table :extra_fields do |t|
      t.integer :cms_page_id
      t.string :field_name
      t.text :field_value
      t.text :field_setting

      t.timestamps null: false
    end
  end
end
