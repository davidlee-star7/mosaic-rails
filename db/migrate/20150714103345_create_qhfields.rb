class CreateQhfields < ActiveRecord::Migration
  def change
    create_table :qhfields do |t|
      t.text :fval
      t.integer  :question_id, null: false 
      t.integer :forder
      t.integer :fnumber
      t.string :optional_title
      t.string :special_settings
      t.boolean :fixed
      t.boolean :require
      t.timestamps null: false
    end
  end
end
