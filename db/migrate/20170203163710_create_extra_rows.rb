class CreateExtraRows < ActiveRecord::Migration
  def change
    create_table :extra_rows do |t|
      t.belongs_to :cms_page, index: true
      t.string :row_name
      t.integer :position
      t.timestamps null: false
    end
  end
end
