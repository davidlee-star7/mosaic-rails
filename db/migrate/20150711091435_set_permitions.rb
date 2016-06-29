class SetPermitions < ActiveRecord::Migration
  def change
  	create_table :permitions do |t|
      t.string :action
      t.string :action_class
      t.text :description
      t.integer :role_id
      t.integer :status
      t.timestamps null: false
    end
  end
end
