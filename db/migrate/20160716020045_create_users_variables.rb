class CreateUsersVariables < ActiveRecord::Migration
  def change
    create_table :users_variables do |t|
      t.integer  :user_id,     null: false
      t.integer  :variable_id,  null: false
      t.text     :value_text,        null: false
      t.timestamps null: false
    end
    add_index :users_variables, [:user_id, :variable_id], unique: true
  end
end
