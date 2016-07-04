class CreateVariables < ActiveRecord::Migration
  def change
    create_table :variables do |t|
      t.string :name,               null: false, default: ""
      t.string :vtype,              null: false
      t.string :identifier,         null: false
      t.timestamps null: false
    end
    add_index :variables, :name, unique: true
    add_index :variables, :identifier, unique: true
  end
end
