class CreateTableaus < ActiveRecord::Migration
  def change
    create_table :tableaus do |t|
      t.string :width
      t.string :height
      t.string :site_root
      t.string :tabs
      t.string :toolbar
      t.string :ticket
      t.string :load_order
      t.string :status

      t.timestamps null: false
    end
  end
end
