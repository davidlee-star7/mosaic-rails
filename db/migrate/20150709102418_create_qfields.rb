class CreateQfields < ActiveRecord::Migration
  def change
    create_table :qfields do |t|
      t.text :fval
      t.integer :type_id
      t.integer :forder
      t.integer :fnumber
      t.string :optional_title
      t.string :data_entry_key_code
      t.string :special_settings
      t.string :group_name
      t.boolean :fixed
      t.boolean :excluded_from_piping
      t.timestamps null: false
    end
  end
end
