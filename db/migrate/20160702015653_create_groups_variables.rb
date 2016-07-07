class CreateGroupsVariables < ActiveRecord::Migration
  def change
    create_table :groups_variables do |t|
      t.integer  :group_id,     null: false
      t.integer  :variable_id,  null: false
      t.text   	 :value_text,        null: false
      t.timestamps null: false
    end
    add_index :groups_variables, [:group_id, :variable_id], unique: true
  end
end
